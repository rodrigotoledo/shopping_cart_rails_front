# frozen_string_literal: true

class PayShoppingCartJob < ApplicationJob
  queue_as :default

  def perform(shopping_cart_id)
    ShoppingCart.pay(shopping_cart_id)
  end
end
