defmodule GoExchangeIdeaBoard.Repo.Migrations.CreateRetroSessions do
  use Ecto.Migration

  def change do
    create table(:retro_sessions) do
      add :date, :naive_datetime
      add :retro_format_id, references(:retro_formats, on_delete: :nothing)

      timestamps()
    end

    create index(:retro_sessions, [:retro_format_id])
  end
end
