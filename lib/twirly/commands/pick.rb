module Twirly
  module Commands
    class Pick < Base
      def run
        (Twirly::Compiler.new).pick Twirly::Post.find(args.first.to_i)
      end
    end
  end
end
