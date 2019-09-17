defmodule GoExchangeIdeaBoardWeb.NoteLive.Edit do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.Retrospectives.Notes
  alias GoExchangeIdeaBoardWeb.NoteView

  def mount(%{path_params: %{"id" => id}}, socket) do
    note = Notes.get_note!(id)

    {:ok,
     assign(socket, %{
       note: note,
       changeset: Notes.change_note(note)
     })}
  end

  def render(assigns), do: NoteView.render("edit.html", assigns)
end
