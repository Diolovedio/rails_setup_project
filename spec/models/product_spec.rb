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
      end

      it "adiciona erro no campo name quando ausente" do
        product.name = nil
        product.valid?
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
      end

      it "adiciona erro no campo sku quando duplicado" do
        create(:product, sku: "DUPLICADO")
        duplicate = build(:product, sku: "DUPLICADO")
        duplicate.valid?
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
      it "retorna produtos que correspondem ao nome" do
        create(:product, name: "Caneta Azul", sku: "CAN001")
        create(:product, name: "Lápis Preto", sku: "LAP001")
        expect(Product.by_name("caneta").map(&:name)).to include("Caneta Azul")
      end

      it "não retorna produtos que não correspondem ao nome" do
        create(:product, name: "Caneta Azul", sku: "CAN001")
        create(:product, name: "Lápis Preto", sku: "LAP001")
        expect(Product.by_name("caneta").map(&:name)).not_to include("Lápis Preto")
      end

      it "ignora acentos na busca" do
        create(:product, name: "Lápis Preto HB", sku: "LAP001")
        expect(Product.by_name("Lapis").map(&:name)).to include("Lápis Preto HB")
      end
    end

    describe ".ordered_by" do
      it "ordena por nome ascendente" do
        create(:product, name: "Zebra", sku: "ZBR001")
        create(:product, name: "Abelha", sku: "ABL001")
        expect(Product.ordered_by("name", "asc").first.name).to eq("Abelha")
      end

      it "ordena por nome descendente" do
        create(:product, name: "Zebra", sku: "ZBR001")
        create(:product, name: "Abelha", sku: "ABL001")
        expect(Product.ordered_by("name", "desc").first.name).to eq("Zebra")
      end

      it "não levanta erro para campos inválidos" do
        expect { Product.ordered_by("campo_invalido", "asc").to_a }.not_to raise_error
      end
    end
  end
end
