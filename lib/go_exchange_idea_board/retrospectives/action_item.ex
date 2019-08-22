defmodule GoExchangeIdeaBoard.Retrospectives.ActionItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoExchangeIdeaBoard.Retrospectives.RetroSession

  schema "action_items" do
    field :completed, :boolean, default: false
    field :content, :string

    belongs_to(:retro_sessions, RetroSession, foreign_key: :retro_session_id)

    timestamps()
  end

  @doc false
  def changeset(action_item, attrs) do
    action_item
    |> cast(attrs, [:content, :completed])
    |> validate_required([:content, :completed])
  end
end
