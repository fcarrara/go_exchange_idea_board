defmodule GoExchangeIdeaBoard.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :content, :string
      add :retro_session_id, references(:retro_sessions, on_delete: :nothing)
      add :retro_format_column_id, references(:retro_format_columns, on_delete: :nothing)

      timestamps()
    end

    create index(:notes, [:retro_session_id])
    create index(:notes, [:retro_format_column_id])
  end
end
