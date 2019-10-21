defmodule GoExchangeIdeaBoardWeb.ActionItemLive.New do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.{ActionItem, ActionItems}
  alias GoExchangeIdeaBoardWeb.ActionItemView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok,
     assign(socket, %{
       changeset: ActionItems.change_action_item(%ActionItem{})
     })}
  end

  def render(assigns), do: ActionItemView.render("new.html", assigns)

  def handle_event("validate", %{"action_item" => action_item_params}, socket) do
    changeset =
      %ActionItem{}
      |> ActionItems.change_action_item(action_item_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"action_item" => action_item_params}, socket) do
    case ActionItems.create_action_item(action_item_params) do
      {:ok, _action_item} ->
        {:stop,
         socket
         |> redirect(to: Routes.action_item_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
