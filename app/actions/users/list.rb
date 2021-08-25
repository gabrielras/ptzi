# frozen_string_literal: true

module Users
  class List < Actor
    output :list, type: Enumerable

    def call
      self.list = User.all
    end
  end
end
