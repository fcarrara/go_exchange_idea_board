defmodule GoExchangeIdeaBoard.Repo.Migrations.CreateActionItems do
  use Ecto.Migration

  def change do
    create table(:action_items) do
      add :content, :string
      add :completed, :boolean, default: false, null: false
      add :retro_session_id, references(:retro_sessions, on_delete: :nothing)

      timestamps()
    end

    create index(:action_items, [:retro_session_id])
  end
end
