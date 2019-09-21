defmodule GoExchangeIdeaBoardWeb.NoteGroupController do
  use GoExchangeIdeaBoardWeb, :controller

  alias GoExchangeIdeaBoard.Retrospectives
  alias GoExchangeIdeaBoard.Retrospectives.NoteGroup

  def index(conn, _params) do
    note_groups = Retrospectives.list_note_groups()
    render(conn, "index.html", note_groups: note_groups)
  end

  def new(conn, _params) do
    changeset = Retrospectives.change_note_group(%NoteGroup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"note_group" => note_group_params}) do
    case Retrospectives.create_note_group(note_group_params) do
      {:ok, note_group} ->
        conn
        |> put_flash(:info, "Note group created successfully.")
        |> redirect(to: Routes.note_group_path(conn, :show, note_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    note_group = Retrospectives.get_note_group!(id)
    render(conn, "show.html", note_group: note_group)
  end

  def edit(conn, %{"id" => id}) do
    note_group = Retrospectives.get_note_group!(id)
    changeset = Retrospectives.change_note_group(note_group)
    render(conn, "edit.html", note_group: note_group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "note_group" => note_group_params}) do
    note_group = Retrospectives.get_note_group!(id)

    case Retrospectives.update_note_group(note_group, note_group_params) do
      {:ok, note_group} ->
        conn
        |> put_flash(:info, "Note group updated successfully.")
        |> redirect(to: Routes.note_group_path(conn, :show, note_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", note_group: note_group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    note_group = Retrospectives.get_note_group!(id)
    {:ok, _note_group} = Retrospectives.delete_note_group(note_group)

    conn
    |> put_flash(:info, "Note group deleted successfully.")
    |> redirect(to: Routes.note_group_path(conn, :index))
  end
end
