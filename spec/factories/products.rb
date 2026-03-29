FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Produto #{n}" }
    description { "Descrição do produto" }
    sequence(:sku) { |n| "SKU#{n.to_s.rjust(4, '0')}" }
    minimum_stock { 10 }
  end
end
