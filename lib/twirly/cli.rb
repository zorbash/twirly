# coding: utf-8

module Twirly
  class CLI < ::Thor
    package_name 'twirly'

    desc 'pull', 'Fetch latest published posts'
    def pull
      Twirly::Commands::Pull.new(args, options).run
    end

    desc 'pick', 'Fetch post by short id'
    def pick(id)
      Twirly::Commands::Pick.new(args, options).run
    end
  end
end
