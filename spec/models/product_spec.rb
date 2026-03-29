require "rails_helper"

RSpec.describe Product, type: :model do
  subject(:product) { build(:product) }

  describe "validações" do
    it "é válido com atributos corretos" do
      expect(product).to be_valid
    end

    describe "name" do
      it "é inválido sem nome" do
        product.name = nil
        expect(product).not_to be_valid
        expect(product.errors[:name]).to be_present
      end

      it "é inválido com nome menor que 2 caracteres" do
        product.name = "A"
        expect(product).not_to be_valid
      end

      it "é válido com nome de exatamente 2 caracteres" do
        product.name = "AB"
        expect(product).to be_valid
      end
    end

    describe "sku" do
      it "é inválido sem SKU" do
        product.sku = nil
        expect(product).not_to be_valid
      end

      it "é inválido com SKU não alfanumérico" do
        product.sku = "ABC-123"
        expect(product).not_to be_valid
      end

      it "é válido com SKU alfanumérico" do
        product.sku = "ABC123"
        expect(product).to be_valid
      end

      it "é inválido com SKU duplicado" do
        create(:product, sku: "DUPLICADO")
        duplicate = build(:product, sku: "DUPLICADO")
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:sku]).to be_present
      end
    end

    describe "minimum_stock" do
      it "é inválido sem estoque mínimo" do
        product.minimum_stock = nil
        expect(product).not_to be_valid
      end

      it "é inválido com estoque mínimo negativo" do
        product.minimum_stock = -1
        expect(product).not_to be_valid
      end

      it "é válido com estoque mínimo igual a zero" do
        product.minimum_stock = 0
        expect(product).to be_valid
      end

      it "é válido com estoque mínimo positivo" do
        product.minimum_stock = 10
        expect(product).to be_valid
      end
    end
  end

  describe "scopes" do
    describe ".by_name" do
      it "filtra produtos pelo nome (case insensitive)" do
        create(:product, name: "Caneta Azul")
        create(:product, name: "Lápis Preto")

        results = Product.by_name("caneta")
        expect(results.map(&:name)).to include("Caneta Azul")
        expect(results.map(&:name)).not_to include("Lápis Preto")
      end
    end

    describe ".ordered_by" do
      it "ordena por nome ascendente" do
        create(:product, name: "Zebra", sku: "ZBR001")
        create(:product, name: "Abelha", sku: "ABL001")

        results = Product.ordered_by("name", "asc")
        expect(results.first.name).to eq("Abelha")
      end

      it "ordena por nome descendente" do
        create(:product, name: "Zebra", sku: "ZBR001")
        create(:product, name: "Abelha", sku: "ABL001")

        results = Product.ordered_by("name", "desc")
        expect(results.first.name).to eq("Zebra")
      end

      it "usa 'id' como campo padrão para campos inválidos" do
        results = Product.ordered_by("campo_invalido", "asc")
        expect { results.to_a }.not_to raise_error
      end
    end
  end
end
