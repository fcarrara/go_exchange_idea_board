defmodule GoExchangeIdeaBoardWeb.ActionItemController do
  use GoExchangeIdeaBoardWeb, :controller

  alias GoExchangeIdeaBoard.Retrospectives
  alias GoExchangeIdeaBoard.Retrospectives.ActionItem

  def index(conn, _params) do
    action_items = Retrospectives.list_action_items()
    render(conn, "index.html", action_items: action_items)
  end

  def new(conn, _params) do
    changeset = Retrospectives.change_action_item(%ActionItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"action_item" => action_item_params}) do
    case Retrospectives.create_action_item(action_item_params) do
      {:ok, action_item} ->
        conn
        |> put_flash(:info, "Action item created successfully.")
        |> redirect(to: Routes.action_item_path(conn, :show, action_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    action_item = Retrospectives.get_action_item!(id)
    render(conn, "show.html", action_item: action_item)
  end

  def edit(conn, %{"id" => id}) do
    action_item = Retrospectives.get_action_item!(id)
    changeset = Retrospectives.change_action_item(action_item)
    render(conn, "edit.html", action_item: action_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "action_item" => action_item_params}) do
    action_item = Retrospectives.get_action_item!(id)

    case Retrospectives.update_action_item(action_item, action_item_params) do
      {:ok, action_item} ->
        conn
        |> put_flash(:info, "Action item updated successfully.")
        |> redirect(to: Routes.action_item_path(conn, :show, action_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", action_item: action_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    action_item = Retrospectives.get_action_item!(id)
    {:ok, _action_item} = Retrospectives.delete_action_item(action_item)

    conn
    |> put_flash(:info, "Action item deleted successfully.")
    |> redirect(to: Routes.action_item_path(conn, :index))
  end
end
