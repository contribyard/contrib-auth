module Contrib
  module Auth
    class Engine < ::Rails::Engine
      isolate_namespace Contrib::Auth
    end
  end
end
