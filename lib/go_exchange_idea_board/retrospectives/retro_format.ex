defmodule GoExchangeIdeaBoard.Retrospectives.RetroFormat do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormatColumn, RetroSession}

  schema "retro_formats" do
    field :name, :string

    has_many(:retro_format_columns, RetroFormatColumn, on_delete: :delete_all, on_replace: :delete)

    has_many(:retro_sessions, RetroSession)

    timestamps()
  end

  @doc false
  def changeset(retro_format, attrs) do
    retro_format
    |> cast(attrs, [:name])
    |> cast_assoc(:retro_format_columns, required: true)
    |> validate_required([:name])
  end
end
