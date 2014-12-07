require 'spec_helper'

describe Twirly::CLI do
  describe '#pull' do
    it 'runs Twirly::Commands::Pull' do
      Twirly::Commands::Pull.any_instance.should_receive(:run)
      Twirly::CLI.start %w(pull)
    end
  end

  describe '#pick' do
    it 'runs Twirly::Commands::Pick' do
      Twirly::Commands::Pick.any_instance.should_receive(:run)
      Twirly::CLI.start %w(pick 42)
    end
  end

  describe '#fetch_user' do
    it 'runs Twirly::Commands::FetchUser' do
      Twirly::Commands::FetchUser.any_instance.should_receive(:run)
      Twirly::CLI.start %w(fetch_user zorbash)
    end
  end
end
