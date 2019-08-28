defmodule GoExchangeIdeaBoard.Retrospectives.RetroFormatColumns do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.Repo
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormatColumn

  def list_retro_format_columns do
    Repo.all(RetroFormatColumn)
  end

  def get_retro_format_column!(id), do: Repo.get!(RetroFormatColumn, id)

  def create_retro_format_column(attrs \\ %{}) do
    %RetroFormatColumn{}
    |> RetroFormatColumn.changeset(attrs)
    |> Repo.insert()
  end

  def update_retro_format_column(%RetroFormatColumn{} = retro_format_column, attrs) do
    retro_format_column
    |> RetroFormatColumn.changeset(attrs)
    |> Repo.update()
  end

  def delete_retro_format_column(%RetroFormatColumn{} = retro_format_column) do
    Repo.delete(retro_format_column)
  end

  def change_retro_format_column(%RetroFormatColumn{} = retro_format_column) do
    RetroFormatColumn.changeset(retro_format_column, %{})
  end
end
