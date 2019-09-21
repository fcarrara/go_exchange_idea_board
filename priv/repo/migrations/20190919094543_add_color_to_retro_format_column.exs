defmodule GoExchangeIdeaBoard.Repo.Migrations.AddColorToRetroFormatColumn do
  use Ecto.Migration

  def change do
    alter table(:retro_format_columns) do
      add :color, :string
    end
  end
end
