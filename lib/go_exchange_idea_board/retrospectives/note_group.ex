defmodule GoExchangeIdeaBoard.Retrospectives.NoteGroup do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoExchangeIdeaBoard.Retrospectives.{Note, RetroFormatColumn}

  schema "note_groups" do
    # field :note_id, :id
    # field :retro_format_column_id, :id

    belongs_to(:retro_format_column, RetroFormatColumn, foreign_key: :retro_format_column_id)
    has_many(:notes, Note)

    timestamps()
  end

  @doc false
  def changeset(note_group, attrs) do
    note_group
    |> cast(attrs, [])
    |> validate_required([])
  end
end
