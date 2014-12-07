module Twirly
  class User < SimpleDelegator
    include Twirly::Serializers::User

    alias :member :__getobj__

    def front_matter
      "#{attributes.to_yaml}\n---"
    end

    def to_md
      "#{front_matter}\n\n#{bio}"
    end

    class << self
      def all
        Twirly.board.members.map do |member|
          user = User.new(member)
          user.refresh!
          user
        end
      end

      def find_by_username(username)
        user = User.new(Twirly.board.members.find { |member| member.username == username })
        user.refresh!
        user
      end
    end
  end
end
