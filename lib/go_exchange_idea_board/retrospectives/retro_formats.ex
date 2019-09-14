defmodule GoExchangeIdeaBoard.Retrospectives.RetroFormats do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.Repo
  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormat, RetroFormatColumns}

  def list_retro_formats do
    RetroFormat
    |> Repo.all()
    |> Repo.preload(:retro_format_columns)
  end

  def get_retro_format!(id) do
    RetroFormat
    |> where(id: ^id)
    |> join(:left, [rf], _ in assoc(rf, :retro_format_columns))
    |> preload([_, rfc], retro_format_columns: rfc)
    |> Repo.one()
  end

  def create_retro_format(attrs \\ %{}) do
    %RetroFormat{}
    |> RetroFormat.changeset(attrs)
    |> Repo.insert()
  end

  def update_retro_format(%RetroFormat{} = retro_format, attrs) do
    retro_format
    |> RetroFormat.changeset(attrs)
    |> Repo.update()
  end

  def delete_retro_format(%RetroFormat{} = retro_format) do
    Repo.delete(retro_format)
  end

  def change_retro_format(%RetroFormat{} = retro_format, attrs \\ %{}) do
    RetroFormat.changeset(retro_format, attrs)
  end
end
