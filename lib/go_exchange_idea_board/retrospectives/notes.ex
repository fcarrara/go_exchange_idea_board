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

  def get_next_group_id(retro_session_id) do
    group_id =
      Repo.one(
        from n in Note,
          where: n.retro_session_id == ^retro_session_id,
          select: max(n.group_id)
      )

    if group_id == nil, do: 1, else: group_id + 1
  end

  def get_notes_in_group(group_id) do
    Repo.all(
      from n in Note,
        where: n.group_id == ^group_id,
        order_by: [asc: n.id]
    )
  end

  def is_grouped?(%Note{} = note) do
    !is_nil(note.group_id)
  end

  def update_column_id(note_id, new_column_id) do
    note = get_note!(note_id)

    if is_grouped?(note) do
      grouped_notes = get_notes_in_group(note.group_id)

      Enum.each(grouped_notes, &update_note(&1, %{retro_format_column_id: new_column_id}))
    else
      update_note(note, %{retro_format_column_id: new_column_id})
    end
  end

  def group_notes(%Note{} = source_note, %Note{} = target_note) do
    if target_note.group_id == nil do
      group_id = get_next_group_id(source_note.retro_session_id)

      update_note(source_note, %{
        group_id: group_id,
        retro_format_column_id: target_note.retro_format_column_id
      })

      update_note(target_note, %{group_id: group_id})
    else
      update_note(source_note, %{
        group_id: target_note.group_id,
        retro_format_column_id: target_note.retro_format_column_id
      })
    end
  end

  def ungroup_note(%Note{} = note) do
    grouped_notes = get_notes_in_group(note.group_id)

    if length(grouped_notes) > 2 do
      update_note(note, %{group_id: nil})
    else
      Enum.each(grouped_notes, &update_note(&1, %{group_id: nil}))
    end
  end
end
