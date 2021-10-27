require 'rails'
require 'jbuilder'

require 'contrib/auth/api'
require 'contrib/auth/provider/google_auth'
require 'contrib/auth/configuration'
require 'contrib/auth/provider/responses'
require 'contrib/auth/version'
require 'contrib/auth/engine'

module Contrib
  module Auth
    class << self
      def config
        @@configuration ||= Configuration.new
      end

      def configure
        yield config if block_given?
      end

      def api
        @@api ||= Api.new(config.provider)
      end
    end
  end
end
