defmodule GoExchangeIdeaBoard.Retrospectives.RetroFormats do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.Repo
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormat

  def list_retro_formats do
    Repo.all(RetroFormat)
  end

  def get_retro_format!(id), do: Repo.get!(RetroFormat, id)

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

  def change_retro_format(%RetroFormat{} = retro_format) do
    RetroFormat.changeset(retro_format, %{})
  end
end
