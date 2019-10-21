defmodule GoExchangeIdeaBoardWeb.ActionItemLive.Edit do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.ActionItems
  alias GoExchangeIdeaBoardWeb.ActionItemView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(%{id: id}, socket) do
    EventCenter.subscribe()

    action_item = ActionItems.get_action_item!(id)

    {:ok,
     assign(socket, %{
       action_item: action_item,
       changeset: ActionItems.change_action_item(action_item)
     })}
  end

  def render(assigns), do: ActionItemView.render("edit.html", assigns)

  def handle_event("validate", %{"action_item" => params}, socket) do
    changeset =
      socket.assigns.action_item
      |> ActionItems.change_action_item(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"action_item" => action_item_params}, socket) do
    case ActionItems.update_action_item(socket.assigns.action_item, action_item_params) do
      {:ok, _action_item} ->
        {:stop,
         socket
         |> redirect(to: Routes.action_item_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
