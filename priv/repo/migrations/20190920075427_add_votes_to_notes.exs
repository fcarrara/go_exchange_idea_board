defmodule GoExchangeIdeaBoard.Repo.Migrations.AddVotesToNotes do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :votes, :integer
    end
  end
end
