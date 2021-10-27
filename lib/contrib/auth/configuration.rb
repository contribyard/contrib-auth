module Contrib
  module Auth
    class Configuration
      attr_accessor :provider

      def initialize(provider = nil)
        self.provider = provider
      end
    end
  end
end
