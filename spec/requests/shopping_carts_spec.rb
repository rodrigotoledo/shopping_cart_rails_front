# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ShoppingCartsController", type: :request do
  describe "GET /shopping_carts" do
    it "assigns all the malls and render the view" do
      carts = [
        ShoppingCart.new(id: 1, customer: "Ana", status: "pending", shopping_cart_items: []),
        ShoppingCart.new(id: 2, customer: "Bruno", status: "paid", shopping_cart_items: [])
      ]

      carts.each do |cart|
        allow(cart).to receive(:persisted?).and_return(true)
      end

      allow(ShoppingCart).to receive(:all).and_return(carts)

      get shopping_carts_path

      expect(response).to have_http_status(:ok)
      expect(assigns(:shopping_carts)).to eq(carts)
      expect(response).to render_template(:index)
    end
  end

  describe "PUT /shopping_carts/:id/pay" do
    it "#pay! and returns status 200" do
      cart = instance_double(ShoppingCart, id: 1)
      allow(ShoppingCart).to receive(:find).with("1").and_return(cart)
      allow(cart).to receive(:pay!)

      put pay_shopping_cart_path(1)

      expect(response).to have_http_status(:ok)
      expect(cart).to have_received(:pay!)
    end

    it "Returns 422" do
      allow(ShoppingCart).to receive(:find).and_raise(StandardError)

      put pay_shopping_cart_path(1)

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "Returns 422 when have error with integration" do
      cart = instance_double(ShoppingCart, id: 1)
      allow(cart).to receive(:pay!).and_raise(StandardError)
      allow(ShoppingCart).to receive(:find).with("1").and_return(cart)

      put pay_shopping_cart_path(1)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /shopping_carts/:id/touch" do
    it "#touch! and returns status 200" do
      cart = instance_double(ShoppingCart, id: 1)
      allow(ShoppingCart).to receive(:find).with("1").and_return(cart)
      allow(cart).to receive(:touch!).and_return(true)

      put touch_shopping_cart_path(1)

      expect(response).to have_http_status(:ok)
      expect(cart).to have_received(:touch!)
    end

    it "Returns 422 when have error with integration" do
      cart = instance_double(ShoppingCart, id: 2)
      allow(cart).to receive(:touch!).and_raise(StandardError)
      allow(ShoppingCart).to receive(:find).with("2").and_return(cart)

      put touch_shopping_cart_path(2)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
