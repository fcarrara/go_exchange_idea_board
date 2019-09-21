defmodule GoExchangeIdeaBoard.Repo.Migrations.CreateNoteGroups do
  use Ecto.Migration

  def change do
    create table(:note_groups) do
      add :note_id, references(:notes, on_delete: :nothing)
      add :retro_format_column_id, references(:retro_format_columns, on_delete: :nothing)

      timestamps()
    end

    create index(:note_groups, [:note_id])
    create index(:note_groups, [:retro_format_column_id])
  end
end
