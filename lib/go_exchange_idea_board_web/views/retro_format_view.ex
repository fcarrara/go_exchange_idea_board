defmodule GoExchangeIdeaBoardWeb.RetroFormatView do
  use GoExchangeIdeaBoardWeb, :view

  alias GoExchangeIdeaBoardWeb.{RetroFormatColumnView, RetroFormatLive}

  def check_errors(input, field) do
    error = input.errors[field]

    if error == nil, do: nil, else: elem(error, 0)
  end
end
