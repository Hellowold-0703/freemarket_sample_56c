require 'rails_helper'

describe ProductsController do
  describe "#show" do
    it "responds successfully" do
    @product = FactoryBot.create(:product)
    get :show, params: {id: @product.id}
    expect(response).to be_success
  end
    
    it "renders the :show template" do
      @product = FactoryBot.create(:product)
      get :show, params: {id: @product.id}
      expect(response).to render_template :show
    end
  end
end
