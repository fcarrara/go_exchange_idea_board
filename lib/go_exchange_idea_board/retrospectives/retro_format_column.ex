defmodule GoExchangeIdeaBoard.Retrospectives.RetroFormatColumn do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoExchangeIdeaBoard.Retrospectives.{Note, RetroFormat}

  schema "retro_format_columns" do
    field :column_title, :string

    belongs_to(:retro_formats, RetroFormat, foreign_key: :retro_format_id)
    has_many(:notes, Note)

    timestamps()
  end

  @doc false
  def changeset(retro_format_column, attrs) do
    retro_format_column
    |> cast(attrs, [:column_title])
    |> validate_required([:column_title])
  end
end
