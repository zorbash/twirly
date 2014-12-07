module Twirly
  module Commands
    class FetchUser < Base
      def run
        (Twirly::Compiler.new).fetch_user Twirly::User.find_by_username(args.first)
      end
    end
  end
end
