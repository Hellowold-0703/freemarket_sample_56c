FactoryBot.define do
  factory :product do
    name {"ナイキ"}
    images { [ Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg'), 'spec/fixtures/test.jpg') ] } 
    status {"新品"}
    shipping_charge {"送料負担"}
    shipping_area {"東京都"}
    days_before_shipment {"２日以内"}
    selling_prime {'1800'}
    shipping_method {"らくらくメルカリ便"}
    explanation {"スニーカー"}
    category_id {'2'}
    brand_id {'2'}
    created_at {'2016-01-01T00:00:00Z'}
    updated_at {'2016-01-02T00:00:00Z'}
    likes_count {'1'}
  end
end