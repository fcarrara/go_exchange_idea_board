defmodule GoExchangeIdeaBoardWeb.RetroSessionLive.New do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormats, RetroSession, RetroSessions}
  alias GoExchangeIdeaBoardWeb.RetroSessionLive
  alias GoExchangeIdeaBoardWeb.RetroSessionView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    EventCenter.subscribe()

    retro_formats = RetroFormats.list_retro_formats()

    {:ok,
     assign(socket, %{
       retro_formats: retro_formats,
       changeset: RetroSessions.change_retro_session(%RetroSession{})
     })}
  end

  def render(assigns), do: RetroSessionView.render("new.html", assigns)

  def handle_event("validate", %{"retro_session" => params}, socket) do
    changeset =
      %RetroSession{}
      |> RetroSessions.change_retro_session(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"retro_session" => retro_session_params}, socket) do
    case RetroSessions.create_retro_session(retro_session_params) do
      {:ok, retro_session} ->
        {:stop,
         socket
         |> put_flash(:info, "Retro session created successfully.")
         |> redirect(to: Routes.live_path(socket, RetroSessionLive.Show, retro_session))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
