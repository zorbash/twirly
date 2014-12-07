require 'spec_helper'

describe Twirly::Commands::Pull do
  describe '#run' do
    let(:args) { ['42'] }

    before do
      Twirly::Post.stub(:find).and_return(create(:post))
    end

    it 'calls Twirly::Compiler#pick' do
      Twirly::Compiler.any_instance.should_receive :pick
      (Twirly::Commands::Pick.new(args, {})).run
    end
  end
end
