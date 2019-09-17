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

    params = convert_list_struct_to_map(retro_format.retro_format_columns)

    {:ok,
     assign(socket, %{
       retro_format: retro_format,
       changeset: RetroFormats.change_retro_format(retro_format),
       params: %{"retro_format_columns" => params}
     })}
  end

  defp convert_list_struct_to_map(retro_format_columns) do
    retro_format_columns
    |> Enum.map(&%{"column_title" => &1.column_title})
    |> Enum.with_index(0)
    |> Enum.map(fn {k, v} -> {v, k} end)
    |> Map.new()
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

  def handle_event("add-column", _, socket) do
    params =
      Map.update!(socket.assigns.params, "retro_format_columns", fn retro_format_columns ->
        cond do
          is_map(retro_format_columns) -> Map.values(retro_format_columns) ++ [%{}]
          is_list(retro_format_columns) -> retro_format_columns ++ [%{}]
        end
      end)

    changeset = RetroFormats.change_retro_format(socket.assigns.changeset.data, params)

    {:noreply, assign(socket, %{changeset: changeset, params: params})}
  end

  def handle_event("delete-column", index, socket) do
    params =
      Map.update!(socket.assigns.params, "retro_format_columns", fn
        retro_format_columns when is_map(retro_format_columns) ->
          Map.drop(retro_format_columns, [String.to_integer(index)])

        retro_format_columns when is_list(retro_format_columns) ->
          List.delete_at(retro_format_columns, String.to_integer(index))
      end)

    changeset = RetroFormats.change_retro_format(socket.assigns.changeset.data, params)

    {:noreply, assign(socket, %{changeset: changeset, params: params})}
  end
end
