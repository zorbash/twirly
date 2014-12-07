require 'spec_helper'

describe Twirly::Commands::FetchUser do
  describe '#run' do
    let(:args) { ['zorbash'] }

    before do
      Twirly::User.stub(:find_by_username).and_return(create(:user))
    end

    it 'calls Twirly::Compiler#fetch_user' do
      Twirly::Compiler.any_instance.should_receive :fetch_user
      (Twirly::Commands::FetchUser.new(args, {})).run
    end
  end
end
