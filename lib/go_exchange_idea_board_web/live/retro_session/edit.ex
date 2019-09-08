defmodule GoExchangeIdeaBoardWeb.RetroSessionLive.Edit do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormats, RetroSessions}
  alias GoExchangeIdeaBoardWeb.RetroSessionLive
  alias GoExchangeIdeaBoardWeb.RetroSessionView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(%{path_params: %{"id" => id}}, socket) do
    retro_session = RetroSessions.get_retro_session!(id)
    retro_formats = RetroFormats.list_retro_formats()

    {:ok,
     assign(socket, %{
       retro_session: retro_session,
       retro_formats: retro_formats,
       changeset: RetroSessions.change_retro_session(retro_session)
     })}
  end

  def render(assigns), do: RetroSessionView.render("edit.html", assigns)

  def handle_event("validate", %{"retro_session" => params}, socket) do
    changeset =
      socket.assigns.retro_session
      |> RetroSessions.change_retro_session(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"retro_session" => retro_session_params}, socket) do
    case RetroSessions.update_retro_session(socket.assigns.retro_session, retro_session_params) do
      {:ok, retro_session} ->
        {:stop,
         socket
         |> put_flash(:info, "Retro session updated successfully.")
         |> redirect(to: Routes.live_path(socket, RetroSessionLive.Show, retro_session))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
