defmodule PhxOptimalFinder.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :string
      add :status, :string

      timestamps()
    end
  end
end
