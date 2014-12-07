require 'spec_helper'

describe Twirly::User do
  let(:trello_member) { create(:trello_member) }

  subject { Twirly::User.new(trello_member) }

  describe '#member' do
    it 'returns a Trello::Member' do
      expect(subject.member.class).to eq(Trello::Member)
    end
  end

  describe '.all' do
    let(:board_members) { create_list(:trello_member, 3) }
    let(:trello_board) { create(:trello_board) }

    before do
      Trello::Board.stub(:find).and_return(trello_board)
      Twirly.board.stub(:members).and_return(board_members)
      Twirly::User.any_instance.stub(:refresh!)
    end

    it 'returns only users decorating board members' do
      expect(Twirly::User.all.map(&:username)).
        to match_array(board_members.map(&:username))
    end
  end

  describe '.find_by_username' do
    let(:matching_member) { create(:trello_member, username: 'zorbash') }
    let(:non_matching_member) { create(:trello_member, username: 'zoidberg') }

    before do
      Twirly.board.stub(:members).and_return([matching_member, non_matching_member])
      Twirly::User.any_instance.stub(:refresh!)
    end

    it 'returns a user from the registered board with a matching trello username' do
      expect(Twirly::User.find_by_username('zorbash').username).to eq('zorbash')
    end
  end
end
