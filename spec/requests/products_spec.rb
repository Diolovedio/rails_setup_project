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

    it "exibe produto que corresponde ao filtro por nome" do
      create(:product, name: "Caneta", sku: "CAN001")
      create(:product, name: "Lapis", sku: "LAP001")
      get products_path, params: { name: "Caneta" }
      expect(response.body).to include("Caneta")
    end

    it "não exibe produto que não corresponde ao filtro por nome" do
      create(:product, name: "Caneta", sku: "CAN001")
      create(:product, name: "Lapis", sku: "LAP001")
      get products_path, params: { name: "Caneta" }
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
      it "cria o produto" do
        expect {
          post products_path, params: { product: valid_attrs }
        }.to change(Product, :count).by(1)
      end

      it "redireciona para o produto criado" do
        post products_path, params: { product: valid_attrs }
        expect(response).to redirect_to(Product.last)
      end
    end

    context "com atributos inválidos" do
      it "não cria o produto" do
        expect {
          post products_path, params: { product: invalid_attrs }
        }.not_to change(Product, :count)
      end

      it "retorna unprocessable_entity" do
        post products_path, params: { product: invalid_attrs }
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
      it "redireciona para o produto" do
        patch product_path(product), params: { product: { name: "Novo Nome" } }
        expect(response).to redirect_to(product)
      end

      it "atualiza o produto" do
        patch product_path(product), params: { product: { name: "Novo Nome" } }
        expect(product.reload.name).to eq("Novo Nome")
      end
    end

    context "com atributos inválidos" do
      it "retorna unprocessable_entity" do
        patch product_path(product), params: { product: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /products/:id" do
    it "destrói o produto" do
      product_to_delete = create(:product)
      expect {
        delete product_path(product_to_delete)
      }.to change(Product, :count).by(-1)
    end

    it "redireciona para a listagem" do
      product_to_delete = create(:product)
      delete product_path(product_to_delete)
      expect(response).to redirect_to(products_url)
    end
  end
end
