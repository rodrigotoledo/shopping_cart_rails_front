# frozen_string_literal: true

require "rails_helper"

RSpec.describe ShoppingCart, type: :model do
  describe "#pending?" do
    it "returns true if status is 'pending'" do
      cart = described_class.new(id: 1, status: "pending")
      expect(cart).to be_pending
    end

    it "returns false if status is not 'pending'" do
      cart = described_class.new(id: 1, status: "paid")
      expect(cart).not_to be_pending
    end
  end

  describe ".pay" do
    it "sends a PUT request to /:id/pay" do
      stub = stub_request(:put, "http://localhost:3001/shopping_carts/123/pay").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type'=>'application/json',
        'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: "", headers: {})

      described_class.pay(123)

      expect(stub).to have_been_requested
    end
  end

  describe "#pay!" do
    it "enqueues PayShoppingCartJob with the cart id" do
      cart = described_class.new(id: 5)
      expect {
        cart.pay!
      }.to have_enqueued_job(PayShoppingCartJob).with(5)
    end
  end

  describe "#touch!" do
    it "Broadcast with Turbo Streams" do
      cart = described_class.new(id: 42)

      expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to).with(
        "shopping_carts",
        target: "shopping_cart_42",
        partial: "shopping_carts/shopping_cart",
        locals: { shopping_cart: cart }
      )

      cart.touch!
    end
  end
end
