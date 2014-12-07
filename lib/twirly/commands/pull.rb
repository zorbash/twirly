module Twirly
  module Commands
    class Pull < Base
      def run
        (Twirly::Compiler.new).pull
      end
    end
  end
end
