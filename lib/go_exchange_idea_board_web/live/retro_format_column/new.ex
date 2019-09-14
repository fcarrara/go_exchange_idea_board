defmodule GoExchangeIdeaBoardWeb.RetroFormatColumnLive.New do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormatColumn, RetroFormatColumns}
  alias GoExchangeIdeaBoardWeb.RetroFormatColumnLive
  alias GoExchangeIdeaBoardWeb.RetroFormatColumnView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    EventCenter.subscribe()

    {:ok,
     assign(socket, %{
       changeset: RetroFormatColumns.change_retro_format_column(%RetroFormatColumn{})
     })}
  end

  def render(assigns), do: RetroFormatColumnView.render("new.html", assigns)

  def handle_event("validate", %{"retro_format_column" => params}, socket) do
    changeset =
      %RetroFormatColumn{}
      |> RetroFormatColumns.change_retro_format_column(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"retro_format_column" => retro_format_column_params}, socket) do
    case RetroFormatColumns.create_retro_format_column(retro_format_column_params) do
      {:ok, retro_format_column} ->
        {:stop,
         socket
         |> redirect(to: Routes.live_path(socket, RetroFormatColumnLive.Show, retro_format_column))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
