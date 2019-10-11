defmodule GoExchangeIdeaBoardWeb.RetroFormatController do
  use GoExchangeIdeaBoardWeb, :controller

  alias GoExchangeIdeaBoardWeb.RetroFormatLive

  def new(conn, _params) do
    live_render(conn, RetroFormatLive.New)
  end

  def index(conn, _params) do
    live_render(conn, RetroFormatLive.Index)
  end

  def edit(conn, %{"id" => id}) do
    live_render(conn, RetroFormatLive.Edit, session: %{id: id})
  end
end
