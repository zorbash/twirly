require 'spec_helper'

describe Twirly::CLI do
  describe '#pull' do
    it 'runs Twirly::Commands::Pull' do
      Twirly::Commands::Pull.any_instance.should_receive(:run)
      Twirly::CLI.start %w(pull)
    end
  end
end
