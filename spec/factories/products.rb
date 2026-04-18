FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    sequence(:sku) { |n| "SKU#{n.to_s.rjust(4, '0')}" }
    minimum_stock { Faker::Number.between(from: 0, to: 100) }
  end
end
