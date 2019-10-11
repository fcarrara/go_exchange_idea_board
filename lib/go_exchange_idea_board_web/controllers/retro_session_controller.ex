defmodule GoExchangeIdeaBoardWeb.RetroSessionController do
  use GoExchangeIdeaBoardWeb, :controller

  alias GoExchangeIdeaBoardWeb.RetroSessionLive

  def new(conn, _params) do
    live_render(conn, RetroSessionLive.New)
  end

  def show(conn, %{"id" => id}) do
    live_render(conn, RetroSessionLive.Show, session: %{id: id})
  end

  def index(conn, _params) do
    live_render(conn, RetroSessionLive.Index)
  end
end
