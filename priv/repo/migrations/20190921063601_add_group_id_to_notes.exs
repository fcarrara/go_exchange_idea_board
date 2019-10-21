defmodule GoExchangeIdeaBoard.Repo.Migrations.AddNoteGroupIdToNotes do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :group_id, :integer
    end
  end
end
