defmodule GoExchangeIdeaBoard.Retrospectives.Notes do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.{EventCenter, Repo}
  alias GoExchangeIdeaBoard.Retrospectives.{Note, RetroFormat, RetroFormatColumn}

  def list_notes() do
    Repo.all(Note)
  end

  def get_columns_with_notes(retro_session_id) do
    RetroFormat
    |> join(:left, [rf], _ in assoc(rf, :retro_format_columns))
    |> join(:left, [_, rfc], _ in assoc(rfc, :notes))
    |> select([_, rfc, n], %RetroFormatColumn{
      id: rfc.id,
      column_title: rfc.column_title,
      notes: %{id: n.id, content: n.content}
    })
    |> where([_, _, n], n.retro_session_id == ^retro_session_id)
    |> Repo.all()
  end

  def get_note!(id), do: Repo.get!(Note, id)

  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
    |> EventCenter.broadcast_change([:note, :created])
  end

  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
    |> EventCenter.broadcast_change([:note, :updated])
  end

  def delete_note(%Note{} = note) do
    note
    |> Repo.delete()
    |> EventCenter.broadcast_change([:note, :deleted])
  end

  def change_note(%Note{} = note) do
    Note.changeset(note, %{})
  end

  def change_note(%Note{} = note, attrs \\ %{}) do
    Note.changeset(note, attrs)
  end
end
