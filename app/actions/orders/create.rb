# frozen_string_literal: true

module Orders
  class Create < Actor
    input :attributes, type: Hash

    output :order, type: Order

    def call
      user_id = create_or_find_user(attributes)

      self.order = Order.create(attributes.except(:user, :user_id).merge(user_id: user_id))
      order.save!
    end

    private

    def create_or_find_user(attributes)
      return find_user(attributes[:user_id]) if attributes[:user_id].present?

      user = User.create(attributes[:user])
      user.id
    end

    def find_user(user_id)
      user = User.where(id: user_id).first
      user&.id
    end
  end
end
