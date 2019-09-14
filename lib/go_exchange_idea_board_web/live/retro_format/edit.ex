defmodule GoExchangeIdeaBoardWeb.RetroFormatLive.Edit do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormats
  alias GoExchangeIdeaBoardWeb.RetroFormatLive
  alias GoExchangeIdeaBoardWeb.RetroFormatView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(%{path_params: %{"id" => id}}, socket) do
    EventCenter.subscribe()

    retro_format = RetroFormats.get_retro_format!(id)

    {:ok,
     assign(socket, %{
       retro_format: retro_format,
       changeset: RetroFormats.change_retro_format(retro_format)
     })}
  end

  def render(assigns), do: RetroFormatView.render("edit.html", assigns)

  def handle_event("validate", %{"retro_format" => params}, socket) do
    changeset =
      socket.assigns.retro_format
      |> RetroFormats.change_retro_format(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"retro_format" => retro_format_params}, socket) do
    case RetroFormats.update_retro_format(socket.assigns.retro_format, retro_format_params) do
      {:ok, retro_format} ->
        {:stop,
         socket
         |> redirect(to: Routes.live_path(socket, RetroFormatLive.Show, retro_format))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
