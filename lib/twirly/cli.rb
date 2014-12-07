# coding: utf-8

module Twirly
  class CLI < ::Thor
    package_name 'twirly'

    desc 'pull', 'Fetch latest published posts'
    def pull
      Twirly::Commands::Pull.new(args, options).run
    end
  end
end
