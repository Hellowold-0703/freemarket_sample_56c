require 'rails_helper'

describe Product do
  describe '#create' do
    it"is valid with a name, explanation, status, shipping_area, days_before_shipment, selling_prime, shipping_method, category_id, brand_id, images " do
      @product = FactoryBot.create(:product)
      expect(@product).to be_valid
    end
  end
end