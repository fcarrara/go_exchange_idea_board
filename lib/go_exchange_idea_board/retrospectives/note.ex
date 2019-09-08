defmodule GoExchangeIdeaBoard.Retrospectives.Note do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormatColumn, RetroSession}

  schema "notes" do
    field :content, :string

    belongs_to(:retro_format_columns, RetroFormatColumn, foreign_key: :retro_format_column_id)
    belongs_to(:retro_sessions, RetroSession, foreign_key: :retro_session_id)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:content, :retro_session_id, :retro_format_column_id])
    |> validate_required([:content])
  end
end
