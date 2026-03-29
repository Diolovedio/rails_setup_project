require "rails_helper"

RSpec.describe "Products", type: :request do
  let(:valid_attrs) { { name: "Produto Teste", sku: "TESTE001", minimum_stock: 5 } }
  let(:invalid_attrs) { { name: "", sku: "", minimum_stock: -1 } }
  let(:product) { create(:product) }

  describe "GET /products" do
    it "retorna sucesso" do
      get products_path
      expect(response).to have_http_status(:ok)
    end

    it "filtra por nome" do
      create(:product, name: "Caneta", sku: "CAN001")
      create(:product, name: "Lapis", sku: "LAP001")
      get products_path, params: { name: "Caneta" }
      expect(response.body).to include("Caneta")
      expect(response.body).not_to include("Lapis")
    end
  end

  describe "GET /products/:id" do
    it "retorna sucesso" do
      get product_path(product)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /products/new" do
    it "retorna sucesso" do
      get new_product_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /products" do
    context "com atributos válidos" do
      it "cria o produto e redireciona" do
        expect {
          post products_path, params: { product: valid_attrs }
        }.to change(Product, :count).by(1)
        expect(response).to redirect_to(Product.last)
      end
    end

    context "com atributos inválidos" do
      it "não cria o produto e renderiza new" do
        expect {
          post products_path, params: { product: invalid_attrs }
        }.not_to change(Product, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /products/:id/edit" do
    it "retorna sucesso" do
      get edit_product_path(product)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /products/:id" do
    context "com atributos válidos" do
      it "atualiza o produto e redireciona" do
        patch product_path(product), params: { product: { name: "Novo Nome" } }
        expect(response).to redirect_to(product)
        expect(product.reload.name).to eq("Novo Nome")
      end
    end

    context "com atributos inválidos" do
      it "não atualiza e renderiza edit" do
        patch product_path(product), params: { product: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /products/:id" do
    it "destrói o produto e redireciona para index" do
      product_to_delete = create(:product)
      expect {
        delete product_path(product_to_delete)
      }.to change(Product, :count).by(-1)
      expect(response).to redirect_to(products_url)
    end
  end
end
