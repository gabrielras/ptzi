# frozen_string_literal: true

module Orders
  class Destroy < Actor
    input :id, type: String

    def call
      order = Order.find(id)
      order.destroy!
    end
  end
end
