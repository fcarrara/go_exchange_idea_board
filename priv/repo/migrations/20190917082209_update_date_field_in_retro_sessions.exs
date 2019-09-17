defmodule GoExchangeIdeaBoard.Repo.Migrations.UpdateDateFieldInRetroSessions do
  use Ecto.Migration

  def change do
    alter table(:retro_sessions) do
      modify :date, :date
    end
  end
end
