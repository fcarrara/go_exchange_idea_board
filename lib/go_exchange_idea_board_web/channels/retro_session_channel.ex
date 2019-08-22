defmodule GoExchangeIdeaBoardWeb.RetroSessionChannel do
  use Phoenix.Channel

  def join("retro-sessions:*", _message, socket) do
    {:ok, socket}
  end
end
