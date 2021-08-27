# frozen_string_literal: true

module Pitzi
  class Orders
    include HTTParty

    base_uri 'http://localhost:3000/api/v1'

    def list
      response = self.class.get('/orders')

      response.parsed_response
    end

    def create(order_params)
      response = self.class.post('/orders', body: { order: order_params })

      response.parsed_response
    end

    def destroy(order_id)
      response = self.class.delete("/orders/#{order_id}")

      response.parsed_response
    end
  end
end
