defmodule GoExchangeIdeaBoard.Repo.Migrations.CreateRetroFormatColumns do
  use Ecto.Migration

  def change do
    create table(:retro_format_columns) do
      add :column_title, :string
      add :retro_format_id, references(:retro_formats, on_delete: :nothing)

      timestamps()
    end

    create index(:retro_format_columns, [:retro_format_id])
  end
end
