defmodule GoExchangeIdeaBoardWeb.RetroSessionLive.Show do
  use GoExchangeIdeaBoardWeb, :controller
  use Phoenix.LiveView
  use Phoenix.HTML

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.{ActionItem, ActionItems, Note, Notes, RetroSessions}
  alias GoExchangeIdeaBoardWeb.{ErrorView, RetroSessionView}
  alias Phoenix.LiveView.Socket

  action_fallback GoExchangeIdeaBoard.FallbackController

  def render(assigns), do: RetroSessionView.render("show.html", assigns)

  def mount(%{id: id}, socket) do
    EventCenter.subscribe()

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
        "add-note",
        %{
          "retro-session-id" => retro_session_id,
          "column-id" => column_id,
          "column-title" => column_title
        },
        socket
      ) do
    note = Notes.change_note(%Note{})

    new_socket =
      assign(socket,
        retro_session_id: retro_session_id,
        column_id: column_id,
        column_title: column_title,
        changeset: note,
        open_modal: true,
        edit_mode: false
      )

    {:noreply, new_socket}
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
      |> assign(:changeset, Notes.change_note(note))
      |> assign(:edit_mode, true)
      |> assign(:note, note)
      |> assign(:open_modal, true)

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
        {:noreply, assign(socket, open_modal: false, changeset: Notes.change_note(%Note{}))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("submit-edit-note", _, %{assigns: %{note_params: note_params}} = socket) do
    case Notes.update_note(socket.assigns.note, note_params) do
      {:ok, _note} ->
        {:noreply, assign(socket, open_modal: false, changeset: Notes.change_note(%Note{}))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("submit-edit-note", %{"value" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("delete-note", id, socket) do
    note = Notes.get_note!(id)
    {:ok, _note} = Notes.delete_note(note)

    {:noreply, fetch(socket)}
  end

  def handle_event(
        "update-note-column-id",
        %{"note_id" => note_id, "new_column_id" => new_column_id},
        socket
      ) do
    note = Notes.get_note!(note_id)
    Notes.update_note(note, %{retro_format_column_id: new_column_id})

    {:noreply, fetch(socket)}
  end

  def handle_info(_, socket) do
    {:noreply, fetch(socket)}
  end
end
