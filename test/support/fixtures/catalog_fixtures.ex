defmodule PhxOptimalFinder.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxOptimalFinder.Catalog` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> PhxOptimalFinder.Catalog.create_product()

    product
  end
end
