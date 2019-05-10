# frozen_string_literal: true

require 'pathname'
require 'socket'

require 'colorize'
require 'database_url'
require 'erubis'
require 'i18n'
begin
  require 'rails'
rescue LoadError
  unless ENV.key?('ORCHESTRATION_TOOLKIT_ONLY')
    STDERR.puts('Rails not detected; continuing without Rails support.')
  end
end

I18n.load_path += Dir[File.join(File.expand_path('..', __dir__),
                                'config', 'locales', '**', '*.yml')]

require 'orchestration/file_helpers'

require 'orchestration/docker_compose'
require 'orchestration/environment'
require 'orchestration/errors'
require 'orchestration/install_generator'
require 'orchestration/railtie' if defined?(Rails)
require 'orchestration/service_check'
require 'orchestration/services'
require 'orchestration/settings'
require 'orchestration/terminal'
require 'orchestration/version'

module Orchestration
  def self.root
    Pathname.new(File.dirname(__dir__))
  end

  def self.rakefile
    root.join('lib', 'Rakefile')
  end

  def self.error(key, options = {})
    STDERR.puts('# Orchestration Error')
    STDERR.puts('# ' + I18n.t("orchestration.#{key}", options))
  end

  def self.random_local_port
    socket = Socket.new(:INET, :STREAM, 0)
    socket.bind(Addrinfo.tcp('127.0.0.1', 0))
    port = socket.local_address.ip_port
    socket.close
    port
  end
end
