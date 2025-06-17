class ShoppingCart < ActiveResource::Base
  self.include_format_in_path = false
  self.site = "http://localhost:3000"
  def pending?
    status.to_s == "pending"
  end

  def self.pay(id)
    put("#{id}/pay")
  end

  def pay!
    PayShoppingCartJob.perform_later(id)
  end

  def touch!
    Turbo::StreamsChannel.broadcast_replace_to(
      'shopping_carts',
      target: "shopping_cart_#{id}",
      partial: 'shopping_carts/shopping_cart',
      locals: { shopping_cart: self }
    )
  end
end