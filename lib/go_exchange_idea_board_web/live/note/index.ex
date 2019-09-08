defmodule GoExchangeIdeaBoardWeb.NoteLive.Index do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.Notes
  alias GoExchangeIdeaBoardWeb.NoteView

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok, fetch(socket)}
  end

  def render(assigns), do: NoteView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, notes: Notes.list_notes())
  end

  def handle_event("delete_note", id, socket) do
    note = Notes.get_note!(id)
    {:ok, _note} = Notes.delete_note(note)

    {:noreply, fetch(socket)}
  end

  def handle_info(%{event: "save"}, socket) do
    {:noreply, fetch(socket)}
  end
end
