defmodule GoExchangeIdeaBoardWeb.RetroFormatController do
  use GoExchangeIdeaBoardWeb, :controller

  alias GoExchangeIdeaBoard.Retrospectives
  alias GoExchangeIdeaBoard.Retrospectives.RetroFormat

  def index(conn, _params) do
    retro_formats = Retrospectives.list_retro_formats()
    render(conn, "index.html", retro_formats: retro_formats)
  end

  def new(conn, _params) do
    changeset = Retrospectives.change_retro_format(%RetroFormat{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"retro_format" => retro_format_params}) do
    case Retrospectives.create_retro_format(retro_format_params) do
      {:ok, retro_format} ->
        conn
        |> put_flash(:info, "Retro format created successfully.")
        |> redirect(to: Routes.retro_format_path(conn, :show, retro_format))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    retro_format = Retrospectives.get_retro_format!(id)
    render(conn, "show.html", retro_format: retro_format)
  end

  def edit(conn, %{"id" => id}) do
    retro_format = Retrospectives.get_retro_format!(id)
    changeset = Retrospectives.change_retro_format(retro_format)
    render(conn, "edit.html", retro_format: retro_format, changeset: changeset)
  end

  def update(conn, %{"id" => id, "retro_format" => retro_format_params}) do
    retro_format = Retrospectives.get_retro_format!(id)

    case Retrospectives.update_retro_format(retro_format, retro_format_params) do
      {:ok, retro_format} ->
        conn
        |> put_flash(:info, "Retro format updated successfully.")
        |> redirect(to: Routes.retro_format_path(conn, :show, retro_format))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", retro_format: retro_format, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    retro_format = Retrospectives.get_retro_format!(id)
    {:ok, _retro_format} = Retrospectives.delete_retro_format(retro_format)

    conn
    |> put_flash(:info, "Retro format deleted successfully.")
    |> redirect(to: Routes.retro_format_path(conn, :index))
  end
end
