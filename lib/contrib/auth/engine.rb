module Contrib
  module Auth
    class Engine < ::Rails::Engine
      isolate_namespace Contrib::Auth

      config.generators do |g|
        g.test_framework :rspec
      end
    end
  end
end
