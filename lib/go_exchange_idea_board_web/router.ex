defmodule GoExchangeIdeaBoardWeb.Router do
  use GoExchangeIdeaBoardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GoExchangeIdeaBoardWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/retro-sessions", RetroSessionController
    resources "/notes", NoteController
    resources "/retro-formats", RetroFormatController
    resources "/retro-format-columns", RetroFormatColumnController
    resources "/action-items", ActionItemController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GoExchangeIdeaBoardWeb do
  #   pipe_through :api
  # end
end
