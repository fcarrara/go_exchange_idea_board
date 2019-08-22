defmodule GoExchangeIdeaBoard.Retrospectives.RetroSession do
  use Ecto.Schema
  import Ecto.Changeset

  schema "retro_sessions" do
    field :date, :naive_datetime
    field :retro_format_id, :id

    timestamps()
  end

  @doc false
  def changeset(retro_session, attrs) do
    retro_session
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end
end
