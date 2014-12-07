require 'spec_helper'

describe Twirly::Serializers::Post do
  let(:trello_board) { create(:trello_board) }
  let(:trello_card) { create(:trello_card, :with_attachments) }

  before do
    trello_card.stub_chain(:list, :name).and_return 'music'
    trello_card.stub(:labels).and_return([double(name: 'post-punk')])
  end

  let(:post) { Twirly::Post.new(trello_card) }

  describe '#as_json' do
    subject { post.as_json }

    it 'is a Hash' do
      expect(subject.as_json).to be_a(Hash)
    end

    it 'has a root key' do
      expect(subject[:post]).to be
    end

    describe 'representation attributes' do
      subject { post.as_json[:post] }

      its(:keys) { should match_array(%w[card_id title category tags
                                         updated_at published_at].
                                           map(&:to_sym)) }
    end
  end

  describe '#to_json' do
    subject { post.to_json }

    it 'is a String' do
      expect(subject.to_json).to be_a(String)
    end
  end
end
