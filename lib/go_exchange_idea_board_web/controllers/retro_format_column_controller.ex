defmodule GoExchangeIdeaBoardWeb.RetroFormatColumnController do
  use GoExchangeIdeaBoardWeb, :controller

  # alias GoExchangeIdeaBoard.Retrospectives.{RetroFormatColumn, RetroFormatColumns}

  # def index(conn, _params) do
  #   retro_format_columns = RetroFormatColumns.list_retro_format_columns()
  #   render(conn, "index.html", retro_format_columns: retro_format_columns)
  # end

  # def new(conn, _params) do
  #   changeset = RetroFormatColumns.change_retro_format_column(%RetroFormatColumn{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"retro_format_column" => retro_format_column_params}) do
  #   case RetroFormatColumns.create_retro_format_column(retro_format_column_params) do
  #     {:ok, retro_format_column} ->
  #       conn
  #       |> put_flash(:info, "Retro format column created successfully.")
  #       |> redirect(to: Routes.retro_format_column_path(conn, :show, retro_format_column))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   retro_format_column = RetroFormatColumns.get_retro_format_column!(id)
  #   render(conn, "show.html", retro_format_column: retro_format_column)
  # end

  # def edit(conn, %{"id" => id}) do
  #   retro_format_column = RetroFormatColumns.get_retro_format_column!(id)
  #   changeset = RetroFormatColumns.change_retro_format_column(retro_format_column)
  #   render(conn, "edit.html", retro_format_column: retro_format_column, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "retro_format_column" => retro_format_column_params}) do
  #   retro_format_column = RetroFormatColumns.get_retro_format_column!(id)

  #   case RetroFormatColumns.update_retro_format_column(
  #          retro_format_column,
  #          retro_format_column_params
  #        ) do
  #     {:ok, retro_format_column} ->
  #       conn
  #       |> put_flash(:info, "Retro format column updated successfully.")
  #       |> redirect(to: Routes.retro_format_column_path(conn, :show, retro_format_column))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", retro_format_column: retro_format_column, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   retro_format_column = RetroFormatColumns.get_retro_format_column!(id)

  #   {:ok, _retro_format_column} =
  #     RetroFormatColumns.delete_retro_format_column(retro_format_column)

  #   conn
  #   |> put_flash(:info, "Retro format column deleted successfully.")
  #   |> redirect(to: Routes.retro_format_column_path(conn, :index))
  # end
end
