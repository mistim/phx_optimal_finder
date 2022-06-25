defmodule PhxOptimalFinder.CatalogTest do
  use PhxOptimalFinder.DataCase

  alias PhxOptimalFinder.Catalog

  describe "products" do
    alias PhxOptimalFinder.Catalog.Product

    import PhxOptimalFinder.CatalogFixtures

    @invalid_attrs %{title: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.title == "some title"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.title == "some updated title"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end

  alias PhxOptimalFinder.Catalog.Product

  @valid_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  describe "#paginate_products/1" do
    test "returns paginated list of products" do
      for _ <- 1..20 do
        product_fixture()
      end

      {:ok, %{products: products} = page} = Catalog.paginate_products(%{})

      assert length(products) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_products/0" do
    test "returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end
  end

  describe "#get_product!/1" do
    test "returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end
  end

  describe "#create_product/1" do
    test "with valid data creates a product" do
      assert {:ok, %Product{} = product} = Catalog.create_product(@valid_attrs)
      assert product.title == "some title"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end
  end

  describe "#update_product/2" do
    test "with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Catalog.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.title == "some updated title"
    end

    test "with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end
  end

  describe "#delete_product/1" do
    test "deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end
  end

  describe "#change_product/1" do
    test "returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end

  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Catalog.create_product()

    product
  end

end
