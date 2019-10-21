defmodule GoExchangeIdeaBoardWeb.ActionItemLive.Index do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.ActionItems
  alias GoExchangeIdeaBoardWeb.ActionItemView

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok, fetch(socket)}
  end

  def render(assigns), do: ActionItemView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, action_items: ActionItems.list_action_items())
  end

  def handle_event("delete_action_item", %{"id" => id}, socket) do
    action_item = ActionItems.get_action_item!(id)
    {:ok, _action_item} = ActionItems.delete_action_item(action_item)

    {:noreply, fetch(socket)}
  end

  def handle_info(%{event: "save"}, socket) do
    {:noreply, fetch(socket)}
  end
end
