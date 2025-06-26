# frozen_string_literal: true

module ShoppingCartsHelper
  def amount_of_shopping_cart_item(shopping_cart_item)
    shopping_cart_item.quantity * shopping_cart_item.price
  rescue
    0
  end
end
