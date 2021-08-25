# frozen_string_literal: true

module Pitzi
  class BaseAPI < Grape::API
    cascade false

    mount Pitzi::V1::BaseAPI
  end
end
