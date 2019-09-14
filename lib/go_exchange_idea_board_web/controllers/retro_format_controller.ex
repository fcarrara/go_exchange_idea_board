defmodule GoExchangeIdeaBoardWeb.RetroFormatController do
  use GoExchangeIdeaBoardWeb, :controller

  # alias GoExchangeIdeaBoard.Retrospectives.{RetroFormat, RetroFormats}

  # def index(conn, _params) do
  #   retro_formats = RetroFormats.list_retro_formats()
  #   render(conn, "index.html", retro_formats: retro_formats)
  # end

  # def new(conn, _params) do
  #   changeset = RetroFormats.change_retro_format(%RetroFormat{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"retro_format" => retro_format_params}) do
  #   case RetroFormats.create_retro_format(retro_format_params) do
  #     {:ok, _retro_format} ->
  #       conn
  #       |> redirect(to: Routes.retro_format_column_path(conn, :new))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   retro_format = RetroFormats.get_retro_format!(id)
  #   render(conn, "show.html", retro_format: retro_format)
  # end

  # def edit(conn, %{"id" => id}) do
  #   retro_format = RetroFormats.get_retro_format!(id)
  #   changeset = RetroFormats.change_retro_format(retro_format)
  #   render(conn, "edit.html", retro_format: retro_format, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "retro_format" => retro_format_params}) do
  #   retro_format = RetroFormats.get_retro_format!(id)

  #   case RetroFormats.update_retro_format(retro_format, retro_format_params) do
  #     {:ok, retro_format} ->
  #       conn
  #       |> redirect(to: Routes.retro_format_path(conn, :show, retro_format))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", retro_format: retro_format, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   retro_format = RetroFormats.get_retro_format!(id)
  #   {:ok, _retro_format} = RetroFormats.delete_retro_format(retro_format)

  #   conn
  #   |> redirect(to: Routes.retro_format_path(conn, :index))
  # end
end
