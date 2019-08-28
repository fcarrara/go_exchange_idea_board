defmodule GoExchangeIdeaBoard.Retrospectives.Notes do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.{EventCenter, Repo}
  alias GoExchangeIdeaBoard.Retrospectives.Note

  def list_notes do
    Repo.all(Note)
  end

  def get_note!(id), do: Repo.get!(Note, id)

  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()

    # |> EventCenter.broadcast_change([:note, :created])
  end

  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()

    # |> EventCenter.broadcast_change([:note, :updated])
  end

  def delete_note(%Note{} = note) do
    note
    |> Repo.delete()

    # |> EventCenter.broadcast_change([:note, :deleted])
  end

  def change_note(%Note{} = note) do
    Note.changeset(note, %{})
  end
end
