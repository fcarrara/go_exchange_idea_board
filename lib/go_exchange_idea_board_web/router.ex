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

    resources "/retro-sessions", RetroSessionController, only: [:new, :index, :show]
    resources "/retro-formats", RetroFormatController, only: [:new, :index, :edit]
    resources "/action-items", ActionItemController, only: [:new, :index, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", GoExchangeIdeaBoardWeb do
  #   pipe_through :api
  # end
end
