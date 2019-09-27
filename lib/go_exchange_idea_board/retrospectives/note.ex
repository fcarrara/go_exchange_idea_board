defmodule GoExchangeIdeaBoard.Retrospectives.Note do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormatColumn, RetroSession}

  schema "notes" do
    field :content, :string
    field :votes, :integer, default: 0
    field :group_id, :integer

    belongs_to(:retro_format_column, RetroFormatColumn, foreign_key: :retro_format_column_id)
    belongs_to(:retro_session, RetroSession, foreign_key: :retro_session_id)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:content, :votes, :retro_session_id, :retro_format_column_id, :group_id])
    |> validate_required([:content])
  end
end
