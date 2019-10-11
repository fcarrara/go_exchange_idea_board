defmodule GoExchangeIdeaBoardWeb.ActionItemController do
  use GoExchangeIdeaBoardWeb, :controller

  alias GoExchangeIdeaBoardWeb.ActionItemLive

  def index(conn, _params) do
    live_render(conn, ActionItemLive.Index)
  end

  def new(conn, _params) do
    live_render(conn, ActionItemLive.New)
  end

  def edit(conn, %{"id" => id}) do
    live_render(conn, ActionItemLive.Edit, session: %{id: id})
  end
end
