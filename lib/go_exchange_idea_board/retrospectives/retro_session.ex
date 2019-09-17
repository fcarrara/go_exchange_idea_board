defmodule GoExchangeIdeaBoard.Retrospectives.RetroSession do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoExchangeIdeaBoard.Retrospectives.{ActionItem, RetroFormat}

  schema "retro_sessions" do
    field :date, :date

    belongs_to(:retro_format, RetroFormat)
    has_many(:action_items, ActionItem)
    timestamps()
  end

  @doc false
  def changeset(retro_session, attrs) do
    retro_session
    |> cast(attrs, [:date, :retro_format_id])
    |> validate_required([:date])
  end
end
