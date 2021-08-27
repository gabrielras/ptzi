# frozen_string_literal: true

module Pitzi
  class Users
    include HTTParty

    base_uri 'http://localhost:3000/api/v1'

    def list
      response = self.class.get('/users')

      response.parsed_response
    end

    def create(user_params)
      response = self.class.post('/users', body: { user: user_params })

      response.parsed_response
    end

    def update(user_id, user_params)
      response = self.class.put("/users/#{user_id}", body: { id: user_id, user: user_params })

      response.parsed_response
    end

    def destroy(user_id)
      response = self.class.delete("/users/#{user_id}")

      response.parsed_response
    end
  end
end
