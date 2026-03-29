# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

products = [
  { name: "Caneta Esferográfica Azul", sku: "CAN001AZL", description: "Caneta esferográfica ponta média, cor azul", minimum_stock: 50 },
  { name: "Caderno Universitário 200 Folhas", sku: "CAD200UN", description: "Caderno capa dura, 200 folhas pautadas", minimum_stock: 30 },
  { name: "Grampeador de Mesa", sku: "GRM001ME", description: "Grampeador metálico para até 20 folhas", minimum_stock: 10 },
  { name: "Papel A4 Resma 500 Folhas", sku: "PPL500A4", description: "Papel sulfite A4 75g/m²", minimum_stock: 20 },
  { name: "Tesoura Escolar", sku: "TES001ESC", description: "Tesoura com ponta arredondada 13cm", minimum_stock: 15 },
  { name: "Fita Adesiva Transparente", sku: "FTA001TR", description: "Fita adesiva 12mm x 30m", minimum_stock: 40 },
  { name: "Marcador de Texto Amarelo", sku: "MRC001AM", description: "Marcador fluorescente cor amarela", minimum_stock: 25 },
  { name: "Borracha Branca", sku: "BOR001BR", description: "Borracha macia para lápis", minimum_stock: 60 },
  { name: "Lápis Preto HB", sku: "LPS001HB", description: "Lápis grafite HB, caixa com 12 unidades", minimum_stock: 35 },
  { name: "Clipe Galvanizado Nº 2", sku: "CLP002GAL", description: "Caixa com 100 clipes galvanizados", minimum_stock: 20 },
  { name: "Pasta Suspensa Kraft", sku: "PST001KR", description: "Pasta suspensa em papel kraft com etiqueta", minimum_stock: 12 },
  { name: "Régua de 30cm", sku: "REG030CM", description: "Régua plástica transparente 30cm", minimum_stock: 18 },
  { name: "Corretivo Líquido", sku: "COR001LQ", description: "Corretivo líquido branco 18ml", minimum_stock: 22 },
  { name: "Calculadora de Mesa", sku: "CAL001ME", description: "Calculadora 12 dígitos com display LCD", minimum_stock: 5 }
]

products.each do |attrs|
  Product.find_or_create_by(sku: attrs[:sku]) do |p|
    p.name = attrs[:name]
    p.description = attrs[:description]
    p.minimum_stock = attrs[:minimum_stock]
  end
end

puts "Seed concluído: #{Product.count} produtos no banco."
