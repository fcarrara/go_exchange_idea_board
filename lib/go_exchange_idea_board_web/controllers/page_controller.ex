defmodule GoExchangeIdeaBoardWeb.PageController do
  use GoExchangeIdeaBoardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
