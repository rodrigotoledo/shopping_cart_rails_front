# frozen_string_literal: true

class ShoppingCartsController < ApplicationController
  before_action :set_shopping_cart, only: %i[ pay ]
  protect_from_forgery

  def index
    @shopping_carts = ShoppingCart.all
  end

  def pay
    @shopping_cart.pay!
    head :ok
  rescue
    head :unprocessable_entity
  end

  private

  def set_shopping_cart
    @shopping_cart = ShoppingCart.find(params.expect(:id))
  rescue
    head :unprocessable_entity
  end
end
