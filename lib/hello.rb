module Hello
  ROOT = Pathname(File.dirname(__FILE__)).join('..')
end

require 'colorize'
require 'before_actions'
require 'user_agent_parser'
require 'http_accept_language'
require 'rails-i18n'
require 'nav_lynx'

require_relative 'hello/utils'
require_relative 'hello/engine'
require_relative 'hello/configuration'
require_relative 'hello/encryptor'
require_relative 'hello/errors'
require_relative 'hello/locales'
require_relative 'hello/support'
require_relative 'hello/manager'
require_relative 'hello/railsy'
require_relative 'hello/rails_active_record'
require_relative 'hello/authentication'
