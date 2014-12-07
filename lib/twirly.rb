# coding: utf-8

require 'delegate'
require 'yaml'
require 'thor'
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext'

require 'twirly/version'

autoload :Trello,      'trello'
autoload :Liquid,      'liquid'
autoload :FileUtils,   'file_utils'

I18n.enforce_available_locales = false

module Twirly
  begin
    SETTINGS = YAML.load_file('twirly.yml').deep_symbolize_keys
  rescue Errno::ENOENT
    puts 'twirly.yml was not found, please add one'
  end

  def self.board
    @board ||= Trello::Board.find(SETTINGS[:publishing_board])
  end

  def self.source_dir(dir = './')
    @source ||= (SETTINGS[:source_dir] || File.expand_path(dir))
  end

  autoload :Post,         'twirly/post'
  autoload :User,         'twirly/user'
  autoload :Compiler,     'twirly/compiler'
  autoload :CLI,          'twirly/cli'
  autoload :Commands,     'twirly/commands'
  autoload :Helpers,      'twirly/helpers'
  autoload :Serializers,  'twirly/serializers'
end

# Load all initializers
Dir[File.join(File.expand_path('../../', __FILE__),
    'config/initializers/*')].sort.each(&method(:require))

Liquid::Template.register_tag('youtube', Twirly::Helpers::Youtube)
