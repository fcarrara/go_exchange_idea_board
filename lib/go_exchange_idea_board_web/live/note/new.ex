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

  # def handle_params(
  #       %{
  #         "retro_session_id" => retro_session_id,
  #         "column_id" => column_id,
  #         "column_title" => column_title
  #       },
  #       _uri,
  #       socket
  #     ) do
  #   socket =
  #     socket
  #     |> assign(:retro_session_id, retro_session_id)
  #     |> assign(:column_id, column_id)
  #     |> assign(:column_title, column_title)

  #   {:noreply, socket}
  # end

  def render(assigns), do: NoteView.render("new.html", assigns)

  # def handle_event("validate", %{"note" => params}, socket) do
  #   changeset =
  #     %Note{}
  #     |> Notes.change_note(params)
  #     |> Map.put(:action, :insert)

  #   {:noreply, assign(socket, changeset: changeset)}
  # end

  # def handle_event("save", %{"note" => note_params}, socket) do
  #   case Notes.create_note(note_params) do
  #     {:ok, note} ->
  #       {:stop,
  #        socket
  #        |> put_flash(:info, "Note created successfully.")
  #        |> redirect(to: Routes.live_path(socket, RetroSessionLive.Show, note.retro_session_id))}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, changeset: changeset)}
  #   end
  # end
end
