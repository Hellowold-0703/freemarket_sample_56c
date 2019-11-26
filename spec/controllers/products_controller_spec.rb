require 'rails_helper'

describe ProductsController do
  
  describe "#index" do
    it "Is @products purchased and in the ladies category? " do
    @products = FactoryBot.create_list(:product, 4)
    get :index
    expect(assigns(:products)).to match(@products.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "Is @ladies_items purchased and in the ladies category? " do
    @ladies_products =  FactoryBot.create_list(:product, 4, category_id: 1)
    get :index
    expect(assigns(:ladies_products)).to match(@ladies_products.sort{ |a, b| b.created_at <=> a.created_at } )
     end

    it "Is @chanel_products purchased and in the chanel brand? " do
    @chanel_products =  FactoryBot.create_list(:product, 4, brand_id: 1)
    get :index
    expect(assigns(:chanel_products)).to match(@chanel_products.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "returns the :index template" do
    get :index
    expect(response).to render_template :index
    end
  end


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
