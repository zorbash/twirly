# coding: utf-8

module Twirly
  module Commands
    class Base
      attr_accessor :args, :options

      def initialize(args, options)
        @args = args
        @options = options.dup.symbolize_keys
      end
    end
  end
end
