defmodule GoExchangeIdeaBoardWeb.RetroSessionController do
  use GoExchangeIdeaBoardWeb, :controller

  # alias GoExchangeIdeaBoard.Retrospectives.{
  #   Note,
  #   Notes,
  #   RetroFormatColumns,
  #   RetroFormats,
  #   RetroSession,
  #   RetroSessions
  # }

  # action_fallback GoExchangeIdeaBoard.FallbackController

  # def index(conn, _params) do
  #   retro_sessions = RetroSessions.list_retro_sessions()

  #   render(conn, "index.html", retro_sessions: retro_sessions)

  #   # LiveView.Controller.live_render(conn, "index.html", session: %{retro_sessions: retro_sessions})
  # end

  # def new(conn, _params) do
  #   changeset = RetroSessions.change_retro_session(%RetroSession{})
  #   retro_formats = RetroFormats.list_retro_formats()

  #   render(conn, "new.html", changeset: changeset, retro_formats: retro_formats)
  # end

  # def create(conn, %{"retro_session" => retro_session_params}) do
  #   case RetroSessions.create_retro_session(retro_session_params) do
  #     {:ok, retro_session} ->
  #       conn
  #       |> put_flash(:info, "Retro session created successfully.")
  #       |> redirect(to: Routes.retro_session_path(conn, :show, retro_session))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   retro_session = RetroSessions.get_retro_session!(id)

  #   retro_format_columns =
  #     RetroFormatColumns.list_retro_format_columns(retro_session.retro_format_id)

  #   note_changeset = Notes.change_note(%Note{})

  #   render(conn, "show.html",
  #     retro_session: retro_session,
  #     retro_format_columns: retro_format_columns,
  #     note_changeset: note_changeset
  #   )
  # end

  # def edit(conn, %{"id" => id}) do
  #   retro_session = RetroSessions.get_retro_session!(id)
  #   changeset = RetroSessions.change_retro_session(retro_session)
  #   render(conn, "edit.html", retro_session: retro_session, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "retro_session" => retro_session_params}) do
  #   retro_session = RetroSessions.get_retro_session!(id)

  #   case RetroSessions.update_retro_session(retro_session, retro_session_params) do
  #     {:ok, retro_session} ->
  #       conn
  #       |> put_flash(:info, "Retro session updated successfully.")
  #       |> redirect(to: Routes.retro_session_path(conn, :show, retro_session))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", retro_session: retro_session, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   retro_session = RetroSessions.get_retro_session!(id)
  #   {:ok, _retro_session} = RetroSessions.delete_retro_session(retro_session)

  #   conn
  #   |> put_flash(:info, "Retro session deleted successfully.")
  #   |> redirect(to: Routes.retro_session_path(conn, :index))
  # end
end
