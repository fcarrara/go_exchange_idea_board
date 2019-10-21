defmodule GoExchangeIdeaBoardWeb.RetroSessionLive.Show do
  use GoExchangeIdeaBoardWeb, :controller
  use Phoenix.LiveView
  use Phoenix.HTML

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.{ActionItem, ActionItems, Note, Notes, RetroSessions}
  alias GoExchangeIdeaBoardWeb.RetroSessionView
  alias Phoenix.LiveView.Socket

  action_fallback GoExchangeIdeaBoard.FallbackController

  def render(assigns), do: RetroSessionView.render("show.html", assigns)

  def mount(%{id: id}, socket) do
    EventCenter.subscribe()

    {:ok, fetch(assign(socket, id: id))}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    retro_session = RetroSessions.get_whole_session(id)
    action_items = ActionItems.list_action_items(id)
    note_changeset = Notes.change_note(%Note{})
    action_item_changeset = ActionItems.change_action_item(%ActionItem{})

    assign(socket,
      retro_session: retro_session,
      note_changeset: note_changeset,
      action_item_changeset: action_item_changeset,
      retro_session_id: id,
      column_id: nil,
      column_title: "",
      open_note_modal: false,
      open_discussion_modal: false,
      grouped_notes: [],
      edit_mode: false,
      color: "",
      action_items: action_items,
      notes: []
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
    {:noreply,
     assign(socket,
       retro_session_id: retro_session_id,
       column_id: column_id,
       column_title: column_title,
       note_changeset: Notes.change_note(%Note{}),
       open_note_modal: true,
       edit_mode: false,
       grouped_notes: []
     )}
  end

  def handle_event(
        "edit-note",
        %{
          "retro-session-id" => retro_session_id,
          "column-id" => column_id,
          "column-title" => column_title,
          "id" => id,
          "color" => color
        },
        socket
      ) do
    note = Notes.get_note!(id)
    grouped_notes = if note.group_id != nil, do: Notes.get_notes_in_group(note.group_id), else: []

    {:noreply,
     assign(socket,
       retro_session_id: retro_session_id,
       column_id: column_id,
       column_title: column_title,
       note_changeset: Notes.change_note(note),
       edit_mode: true,
       note: note,
       grouped_notes: grouped_notes,
       open_note_modal: true,
       color: color
     )}
  end

  def handle_event("close-modal", _, socket) do
    {:noreply, assign(socket, open_note_modal: false)}
  end

  def handle_event("validate", %{"note" => note_params}, socket) do
    note_changeset =
      %Note{}
      |> Notes.change_note(note_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, note_changeset: note_changeset, note_params: note_params)}
  end

  def handle_event("validate", %{"action_item" => action_item_params}, socket) do
    action_item_changeset =
      %ActionItem{}
      |> ActionItems.change_action_item(action_item_params)
      |> Map.put(:action, :insert)

    {:noreply,
     assign(socket, action_item_changeset: action_item_changeset, action_item: action_item_params)}
  end

  def handle_event("submit-new-note", _, %{assigns: %{note_params: note_params}} = socket) do
    case Notes.create_note(note_params) do
      {:ok, _note} ->
        {:noreply, assign(socket, open_note_modal: false)}

      {:error, %Ecto.Changeset{} = note_changeset} ->
        {:noreply, assign(socket, note_changeset: note_changeset)}
    end
  end

  def handle_event("submit-edit-note", _, %{assigns: %{note_params: note_params}} = socket) do
    case Notes.update_note(socket.assigns.note, note_params) do
      {:ok, _note} ->
        {:noreply,
         assign(socket, open_note_modal: false, note_changeset: Notes.change_note(%Note{}))}

      {:error, %Ecto.Changeset{} = note_changeset} ->
        {:noreply, assign(socket, note_changeset: note_changeset)}
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
    Notes.update_column_id(note_id, new_column_id)

    {:noreply, fetch(socket)}
  end

  def handle_event(
        "group-notes",
        %{"source_note_id" => source_note_id, "target_note_id" => target_note_id},
        socket
      ) do
    source_note = Notes.get_note!(source_note_id)
    target_note = Notes.get_note!(target_note_id)

    Notes.group_notes(source_note, target_note)

    {:noreply, fetch(socket)}
  end

  def handle_event(
        "ungroup-note",
        %{"note-id" => note_id},
        socket
      ) do
    note_id
    |> Notes.get_note!()
    |> Notes.ungroup_note()

    {:noreply, fetch(socket)}
  end

  def handle_event("submit-vote", %{"note-id" => note_id}, socket) do
    note = Notes.get_note!(note_id)

    Notes.update_note(note, %{votes: note.votes + 1})

    {:noreply, fetch(socket)}
  end

  def handle_event("open-discussion-modal", _, socket) do
    retro_session = socket.assigns.retro_session
    notes_list = []

    notes_list =
      for retro_format_column <- retro_session.retro_format.retro_format_columns do
        for note <- retro_format_column.notes do
          notes_list ++
            %{
              content: note.content,
              color: retro_format_column.color,
              title: retro_format_column.column_title,
              votes: note.votes
            }
        end
      end

    notes_list =
      notes_list
      |> List.flatten()
      |> Enum.reverse()

    {:noreply, assign(socket, notes: notes_list, open_discussion_modal: true)}
  end

  def handle_event("close-discussion-modal", _, socket) do
    {:noreply, assign(socket, open_discussion_modal: false)}
  end

  def handle_event("add-action-item", %{"action_item" => action_item_params}, socket) do
    case ActionItems.create_action_item(action_item_params) do
      {:ok, action_item} ->
        {:noreply,
         assign(socket,
           action_item_changeset: ActionItems.change_action_item(%ActionItem{}),
           action_items: ActionItems.list_action_items(action_item.retro_session_id)
         )}

      {:error, %Ecto.Changeset{} = action_item_changeset} ->
        {:noreply, assign(socket, action_item_changeset: action_item_changeset)}
    end
  end

  def handle_event("update-action-item", %{"action_item" => action_item_params}, socket) do
    case ActionItems.update_action_item(socket.assigns.action_item, action_item_params) do
      {:ok, action_item} ->
        {:noreply,
         assign(socket,
           action_item_changeset: ActionItems.change_action_item(%ActionItem{}),
           action_items: ActionItems.list_action_items(action_item.retro_session_id)
         )}

      {:error, %Ecto.Changeset{} = action_item_changeset} ->
        {:noreply, assign(socket, action_item_changeset: action_item_changeset)}
    end
  end

  def handle_event("delete-action-item", %{"id" => id}, socket) do
    action_item = ActionItems.get_action_item!(id)
    {:ok, _action_item} = ActionItems.delete_action_item(action_item)

    {:noreply,
     assign(socket, action_items: ActionItems.list_action_items(action_item.retro_session_id))}
  end

  def handle_info({GoExchangeIdeaBoard.EventCenter, [:action_item, _], action_item}, socket) do
    {:noreply,
     assign(socket, action_items: ActionItems.list_action_items(action_item.retro_session_id))}
  end

  def handle_info(_, socket) do
    {:noreply, fetch(socket)}
  end
end
