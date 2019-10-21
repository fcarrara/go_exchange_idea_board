defmodule GoExchangeIdeaBoardWeb.NoteLive.New do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.{Note, Notes}
  alias GoExchangeIdeaBoardWeb.NoteView

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok,
     assign(socket, %{
       changeset: Notes.change_note(%Note{})
     })}
  end

  def render(assigns), do: NoteView.render("new.html", assigns)
end
