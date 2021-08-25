# frozen_string_literal: true

module Pitzi
  module V1
    module Helpers
      module RequestHelpers
        def raw_request_body
          raw_data = env[Grape::Env::RACK_REQUEST_FORM_INPUT].read
          env[Grape::Env::RACK_REQUEST_FORM_INPUT].rewind
          raw_data
        end
      end
    end
  end
end
