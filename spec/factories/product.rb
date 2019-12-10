FactoryBot.define do
  factory :product do
    name {"ナイキ"}
    images { [ Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg'), 'spec/fixtures/test.jpg') ] } 
    status {3}
    shipping_charge {2}
    shipping_area {4}
    days_before_shipment {2}
    selling_price {'1800'}
    shipping_method {1}
    explanation {"スニーカー"}
    category_id {21}
    size_id {1}
    display {0}
    created_at {'2016-01-01T00:00:00Z'}
    updated_at {'2016-01-02T00:00:00Z'}
    likes_count {'1'}
  end
end