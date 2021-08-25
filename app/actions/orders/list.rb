# frozen_string_literal: true

module Orders
  class List < Actor
    output :list, type: Enumerable

    def call
      self.list = Order.all
    end
  end
end
