# frozen_string_literal: true

require "rails_helper"

RSpec.describe PayShoppingCartJob, type: :job do
  it "ShoppingCart.pay with the correct id" do
    stub_request(:get, "http://localhost:3001/shopping_carts/123").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: {
            id: 123, customer: Faker::Name.name_with_middle,
            status: "paid",
            created_at: Time.current.to_s,
            updated_at: Time.current.to_s,
            shopping_cart_items: [{id: 358, product: Faker::Commerce.product_name, quantity: 6, price: 293.0}]
          }.to_json, headers: {})

    stub_request(:put, "http://localhost:3001/shopping_carts/123/pay").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "", headers: {})
    expect(ShoppingCart).to receive(:pay).with(123)

    described_class.perform_now(123)
  end
end
