# frozen_string_literal: true

module Users
  class Create < Actor
    input :attributes, type: Hash

    output :user, type: User

    def call
      self.user = User.create!(attributes)
    end
  end
end
