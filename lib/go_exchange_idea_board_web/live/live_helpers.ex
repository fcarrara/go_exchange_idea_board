defmodule GoExchangeIdeaBoardWeb.LiveHelpers do
  import Phoenix.LiveView
  alias Phoenix.LiveView.Socket

  def add_nested_field(socket, field) do
    params =
      Map.update!(socket.assigns.params, field, fn
        field when is_map(field) -> Map.values(field) ++ [%{}]
        field when is_list(field) -> field ++ [%{}]
      end)

    do_changes(socket, params)
  end

  def remove_nested_field(socket, field, index) do
    params =
      Map.update!(socket.assigns.params, field, fn
        field when is_map(field) -> Map.drop(field, [index])
        field when is_list(field) -> List.delete_at(field, String.to_integer(index))
      end)

    do_changes(socket, params)
  end

  defp do_changes(socket, params) do
    changeset = socket
    # |> get_resource
    # It returns a changeset
    # |> Locations.change_region(params)

    assign(socket, %{changeset: changeset, params: params})
  end
end
