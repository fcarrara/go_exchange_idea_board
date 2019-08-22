defmodule GoExchangeIdeaBoard.Repo.Migrations.CreateRetroFormats do
  use Ecto.Migration

  def change do
    create table(:retro_formats) do
      add :name, :string

      timestamps()
    end
  end
end
