defmodule GoExchangeIdeaBoardWeb.RetroFormatLive.New do
  use Phoenix.LiveView

  alias GoExchangeIdeaBoard.EventCenter
  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormats, RetroFormat, RetroFormatColumn}
  alias GoExchangeIdeaBoardWeb.RetroFormatView
  alias GoExchangeIdeaBoardWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    EventCenter.subscribe()

    params = %{
      "retro_format_columns" => %{"0" => %{"column_title" => ""}}
    }

    {:ok,
     assign(socket, %{
       changeset:
         RetroFormats.change_retro_format(%RetroFormat{
           retro_format_columns: [%RetroFormatColumn{}]
         }),
       params: params
     })}
  end

  def render(assigns), do: RetroFormatView.render("new.html", assigns)

  def handle_event("validate", %{"retro_format" => retro_format_params}, socket) do
    changeset =
      %RetroFormat{}
      |> RetroFormats.change_retro_format(retro_format_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset, retro_format: retro_format_params)}
  end

  def handle_event("save", %{"retro_format" => retro_format_params}, socket) do
    case RetroFormats.create_retro_format(retro_format_params) do
      {:ok, _retro_format} ->
        {:stop,
         socket
         |> redirect(to: Routes.retro_format_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("add-column", _, socket) do
    params =
      Map.update!(socket.assigns.params, "retro_format_columns", fn retro_format_columns ->
        cond do
          is_map(retro_format_columns) -> Map.values(retro_format_columns) ++ [%{}]
          is_list(retro_format_columns) -> retro_format_columns ++ [%{}]
        end
      end)

    changeset = RetroFormats.change_retro_format(%RetroFormat{}, params)

    {:noreply, assign(socket, %{changeset: changeset, params: params})}
  end

  def handle_event("delete-column", %{"index" => index}, socket) do
    params =
      Map.update!(socket.assigns.params, "retro_format_columns", fn
        retro_format_columns when is_map(retro_format_columns) ->
          Map.drop(retro_format_columns, [index])

        retro_format_columns when is_list(retro_format_columns) ->
          List.delete_at(retro_format_columns, String.to_integer(index))
      end)

    changeset = RetroFormats.change_retro_format(%RetroFormat{}, params)

    {:noreply, assign(socket, %{changeset: changeset, params: params})}
  end
end
