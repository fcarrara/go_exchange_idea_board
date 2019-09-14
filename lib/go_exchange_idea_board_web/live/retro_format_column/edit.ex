defmodule GoExchangeIdeaBoardWeb.RetroFormatColumnLive.Edit do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormatColumns
  alias GoExchangeIdeaBoardWeb.RetroFormatColumnLive
  alias GoExchangeIdeaBoardWeb.RetroFormatColumnView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(%{path_params: %{"id" => id}}, socket) do
    EventCenter.subscribe()

    retro_format_column = RetroFormatColumns.get_retro_format_column!(id)

    {:ok,
     assign(socket, %{
       retro_format_column: retro_format_column,
       changeset: RetroFormatColumns.change_retro_format_column(retro_format_column)
     })}
  end

  def render(assigns), do: RetroFormatColumnView.render("edit.html", assigns)

  def handle_event("validate", %{"retro_format_column" => params}, socket) do
    changeset =
      socket.assigns.retro_format_column
      |> RetroFormatColumns.change_retro_format_column(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"retro_format_column" => retro_format_column_params}, socket) do
    case RetroFormatColumns.update_retro_format_column(socket.assigns.retro_format_column, retro_format_column_params) do
      {:ok, retro_format_column} ->
        {:stop,
         socket
         |> redirect(to: Routes.live_path(socket, RetroFormatColumnLive.Show, retro_format_column))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
