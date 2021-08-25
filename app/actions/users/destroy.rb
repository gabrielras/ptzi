# frozen_string_literal: true

module Users
  class Destroy < Actor
    input :id, type: String

    def call
      user = User.find(id)
      user.destroy!
    end
  end
end
