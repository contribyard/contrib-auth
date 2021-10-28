module Contrib
  module Auth
    module Provider
      module Responses
        class SignUpWithEmailAndPassword
          attr_accessor :id_token
          attr_accessor :refresh_token
          attr_accessor :expires_in

          def initialize(params = {})
            params.each do  |param, key|
              public_send("#{param}=", key)
            end
          end
        end
      end
    end
  end
end
