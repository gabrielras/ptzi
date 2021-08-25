# frozen_string_literal: true

module Users
  class Update < Actor
    input :id, type: String
    input :attributes, type: Hash

    output :user, type: User

    def call
      self.user = User.find(id)

      user.update!(attributes)
    end
  end
end
