require 'spec_helper'

describe Twirly::Post do
  let(:trello_board) { create(:trello_board) }
  let(:trello_card) { create(:trello_card) }
  let(:front_matter_content) do
    <<-YAML.strip_heredoc.strip
    ---
    important: true
    tags: idm, punk, electro
    ---
    YAML
  end

  let(:markdown_content) do
    <<-MDN.strip_heredoc.strip
    # A post about cats
    > Everybody loves cats
    {% youtube 320 280 4-IpnaqBhT4 %}
    MDN
  end

  let(:post) { Twirly::Post.new(trello_card) }
  subject { post }

  describe '#card' do
    it 'returns a Trello::Card' do
      expect(subject.card.class).to eq(Trello::Card)
    end
  end

  describe '#title' do
    it "is delegated to the card's name" do
      expect(subject.title).to eq(subject.card.name)
    end
  end

  describe '#updated_at' do
    it "is delegated to the card's last_activity_date" do
      expect(subject.updated_at).to eq(subject.card.last_activity_date)
    end
  end

  describe '#created_at' do
    it "is delegated to the card's due" do
      expect(subject.created_at).to eq(subject.card.due)
    end
  end

  describe '#published_at' do
    context 'when the cards due is not nil' do
      it "is set to the value of #due" do
        expect(subject.published_at).to eq(subject.card.due)
      end
    end

    context 'when the cards due is nil' do
      before { post.due = nil }

      it 'is set to the value of #updated_at' do
        expect(subject.published_at).to eq(subject.updated_at)
      end
    end
  end

  describe '#card_id' do
    it "is delegated to the card's id" do
      expect(subject.card_id).to eq(subject.card.short_id)
    end
  end

  describe '#short_published_at' do
    subject { post.short_published_at }

    it { expect(subject).to eq(trello_card.due.strftime('%Y-%m-%d')) }
  end

  describe '#slug' do
    subject { post.slug }
    let(:slug) {"#{post.short_published_at}-#{post.title.parameterize}-#{post.card_id}" }

    it { expect(subject).to eq(slug) }
  end

  describe '#authors' do
    before do
      subject.card.stub(:members).and_return(create_list(:trello_member, 3))
    end

    it "returns the decorated as Twirly::User(s) card members" do
      expect(subject.authors.map(&:username))
        .to match_array(subject.card.members.map(&:username))
    end
  end

  describe '#tags' do
    pending
  end

  describe '#body' do
    pending
  end

  describe '#published?' do
    context 'card is published (has published_at and the "published" label' do
      let(:subject) do
        post = Twirly::Post.new(create(:trello_card, :published))
        post.card.stub(:labels).and_return([double(name: 'published')])
        post
      end

      it 'returns true' do
        expect(subject).to be_published
      end
    end

    context 'card is not published (has published_at and the "published" label' do
      let(:subject) { Twirly::Post.new(create(:trello_card, :unpublished)) }

      it 'returns false' do
        expect(subject).to_not be_published
      end
    end
  end

  describe '.published' do
    let(:unpublished_cards) do
      create_list(:trello_card, 3, :unpublished).map do |card|
        card.stub(:labels).and_return([])
        card
      end
    end

    let(:published_cards) do
      create_list(:trello_card, 4, :published).map do |card|
        card.stub(:labels).and_return([double(name: 'published')])
        card
      end
    end

    before do
      Trello::Board.stub(:find).and_return(trello_board)
      Twirly.board.stub(:cards).and_return(unpublished_cards + published_cards)
    end

    it 'returns only posts decorating published cards' do
      expect(Twirly::Post.published.map(&:card_id)).
        to match_array(published_cards.map(&:short_id))
    end
  end

  describe '.find' do
    let(:matching_card) { create(:trello_card, short_id: 42) }
    let(:non_matching_card) { create(:trello_card, short_id: 404) }

    before do
      Trello::Board.stub(:find).and_return(trello_board)
      Twirly.board.stub(:cards).and_return([matching_card, non_matching_card])
    end

    it 'returns a card from the registered board with a matching trello short_id' do
      expect(Twirly::Post.find(42).card_id).to eq(42)
    end
  end
end
