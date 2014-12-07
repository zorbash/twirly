require 'spec_helper'

describe Twirly::Commands::Pull do
  describe '#run' do
    it 'calls Twirly::Compiler#pull' do
      Twirly::Compiler.any_instance.should_receive :pull
      (Twirly::Commands::Pull.new([], {})).run
    end
  end
end
