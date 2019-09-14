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

    live "/retro-sessions", RetroSessionLive.Index
    live "/retro-sessions/new", RetroSessionLive.New
    live "/retro-sessions/:id", RetroSessionLive.Show
    live "/retro-sessions/:id/edit", RetroSessionLive.Edit

    live "/retro-formats", RetroFormatLive.Index
    live "/retro-formats/new", RetroFormatLive.New
    live "/retro-formats/:id", RetroFormatLive.Show
    live "/retro-formats/:id/edit", RetroFormatLive.Edit

    live "/retro-format-columns", RetroFormatColumnLive.Index
    live "/retro-format-columns/new", RetroFormatColumnLive.New
    live "/retro-format-columns/:id", RetroFormatColumnLive.Show
    live "/retro-format-columns/:id/edit", RetroFormatColumnLive.Edit

    live "/notes/new", NoteLive.New
    live "/notes/edit/:id", NoteLive.Edit

    # resources "/retro-sessions", RetroSessionController
    resources "/notes", NoteController
    # resources "/retro-formats", RetroFormatController
    # resources "/retro-format-columns", RetroFormatColumnController
    resources "/action-items", ActionItemController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GoExchangeIdeaBoardWeb do
  #   pipe_through :api
  # end
end
