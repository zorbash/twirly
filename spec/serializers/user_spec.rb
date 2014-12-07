require 'spec_helper'

describe Twirly::Serializers::User do
  let(:trello_member) { create(:trello_member) }

  let(:user) { Twirly::User.new(trello_member) }

  describe '#as_json' do
    subject { user.as_json }

    it 'is a Hash' do
      expect(subject.as_json).to be_a(Hash)
    end

    it 'has a root key' do
      expect(subject[:user]).to be
    end

    describe 'representation attributes' do
      subject { user.as_json[:user] }

      its(:keys) { should match_array(%w[id username full_name bio avatar_url].
                                        map(&:to_sym)) }
    end
  end

  describe '#to_json' do
    subject { user.to_json }

    it 'is a String' do
      expect(subject.to_json).to be_a(String)
    end
  end
end
