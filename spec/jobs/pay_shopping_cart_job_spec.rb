# frozen_string_literal: true

require "rails_helper"

RSpec.describe PayShoppingCartJob, type: :job do
  it "ShoppingCart.pay with the correct id" do
    expect(ShoppingCart).to receive(:pay).with(123)

    described_class.perform_now(123)
  end
end
