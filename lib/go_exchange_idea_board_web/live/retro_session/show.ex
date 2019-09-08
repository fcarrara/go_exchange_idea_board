defmodule GoExchangeIdeaBoardWeb.RetroSessionLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias GoExchangeIdeaBoard.Retrospectives.{Note, Notes, RetroFormatColumns, RetroSessions}
  alias GoExchangeIdeaBoardWeb.RetroSessionView
  alias GoExchangeIdeaBoardWeb.NoteLive.New
  alias Phoenix.LiveView.Socket
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def render(assigns), do: RetroSessionView.render("show.html", assigns)

  def mount(%{path_params: %{"id" => id}}, socket) do
    {:ok, fetch(assign(socket, id: id))}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    retro_session = RetroSessions.get_whole_session(id)
    changeset = Notes.change_note(%Note{})

    assign(socket,
      retro_session: retro_session,
      changeset: changeset,
      retro_session_id: id,
      column_id: nil,
      column_title: "",
      open_modal: false,
      edit_mode: false
    )
  end

  def handle_event(
        "show-modal",
        %{
          "retro-session-id" => retro_session_id,
          "column-id" => column_id,
          "column-title" => column_title,
          "edit-mode" => edit_mode
        },
        socket
      ) do
    socket =
      socket
      |> assign(:retro_session_id, retro_session_id)
      |> assign(:column_id, column_id)
      |> assign(:column_title, column_title)
      |> assign(:open_modal, true)
      |> assign(:edit_mode, String.to_existing_atom(edit_mode))

    {:noreply, socket}
  end

  def handle_event(
        "edit-note",
        %{
          "retro-session-id" => retro_session_id,
          "column-id" => column_id,
          "column-title" => column_title,
          "id" => id
        },
        socket
      ) do
    note = Notes.get_note!(id)

    socket =
      socket
      |> assign(:retro_session_id, retro_session_id)
      |> assign(:column_id, column_id)
      |> assign(:column_title, column_title)
      |> assign(:open_modal, true)
      |> assign(:edit_mode, true)
      |> assign(:changeset, Notes.change_note(note))
      |> assign(:note, note)

    {:noreply, socket}
  end

  def handle_event("close-modal", _, socket), do: {:noreply, assign(socket, :open_modal, false)}

  def handle_event("validate", %{"note" => note_params}, socket) do
    changeset =
      %Note{}
      |> Notes.change_note(note_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset, note_params: note_params)}
  end

  def handle_event("submit-new-note", _, %{assigns: %{note_params: note_params}} = socket) do
    case Notes.create_note(note_params) do
      {:ok, _note} ->
        socket = assign(socket, open_modal: false, changeset: Notes.change_note(%Note{}))

        {:noreply,
         socket
         |> redirect(
           to:
             Routes.live_path(
               socket,
               GoExchangeIdeaBoardWeb.RetroSessionLive.Show,
               Map.get(note_params, "retro_session_id")
             )
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

    def handle_event("submit-edit-note", _, %{assigns: %{note_params: note_params}} = socket) do
    case Notes.update_note(socket.assigns.note, note_params) do
      {:ok, note} ->
        socket = assign(socket, open_modal: false, changeset: Notes.change_note(%Note{}))

        {:noreply,
         socket
         |> redirect(
           to:
             Routes.live_path(
               socket,
               GoExchangeIdeaBoardWeb.RetroSessionLive.Show,
               Map.get(note_params, "retro_session_id")
             )
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("delete-note", id, socket) do
    note = Notes.get_note!(id)
    {:ok, _note} = Notes.delete_note(note)

    {:noreply, fetch(socket)}
  end
end
