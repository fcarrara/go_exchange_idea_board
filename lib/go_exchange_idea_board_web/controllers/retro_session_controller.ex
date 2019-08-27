defmodule GoExchangeIdeaBoardWeb.RetroSessionController do
#   use GoExchangeIdeaBoardWeb, :controller

#   alias GoExchangeIdeaBoard.Retrospectives
#   alias GoExchangeIdeaBoard.Retrospectives.RetroSession
#   # alias Phoenix.LiveView

#   action_fallback GoExchangeIdeaBoard.FallbackController

#   # def index(conn, _params) do
#   #   retro_sessions = Retrospectives.list_retro_sessions()
#   #   # render(conn, "index.html", retro_sessions: retro_sessions)
#   #   LiveView.Controller.live_render(conn, "index.html", session: %{retro_sessions: retro_sessions})
#   # end

#   def new(conn, _params) do
#     changeset = Retrospectives.change_retro_session(%RetroSession{})
#     render(conn, "new.html", changeset: changeset)
#   end

#   def create(conn, %{"retro_session" => retro_session_params}) do
#     case Retrospectives.create_retro_session(retro_session_params) do
#       {:ok, retro_session} ->
#         conn
#         |> put_flash(:info, "Retro session created successfully.")
#         |> redirect(to: Routes.retro_session_path(conn, :show, retro_session))

#       {:error, %Ecto.Changeset{} = changeset} ->
#         render(conn, "new.html", changeset: changeset)
#     end
#   end

#   def show(conn, %{"id" => id}) do
#     retro_session = Retrospectives.get_retro_session!(id)
#     render(conn, "show.html", retro_session: retro_session)
#   end

#   def edit(conn, %{"id" => id}) do
#     retro_session = Retrospectives.get_retro_session!(id)
#     changeset = Retrospectives.change_retro_session(retro_session)
#     render(conn, "edit.html", retro_session: retro_session, changeset: changeset)
#   end

#   def update(conn, %{"id" => id, "retro_session" => retro_session_params}) do
#     retro_session = Retrospectives.get_retro_session!(id)

#     case Retrospectives.update_retro_session(retro_session, retro_session_params) do
#       {:ok, retro_session} ->
#         conn
#         |> put_flash(:info, "Retro session updated successfully.")
#         |> redirect(to: Routes.retro_session_path(conn, :show, retro_session))

#       {:error, %Ecto.Changeset{} = changeset} ->
#         render(conn, "edit.html", retro_session: retro_session, changeset: changeset)
#     end
#   end

#   def delete(conn, %{"id" => id}) do
#     retro_session = Retrospectives.get_retro_session!(id)
#     {:ok, _retro_session} = Retrospectives.delete_retro_session(retro_session)

#     conn
#     |> put_flash(:info, "Retro session deleted successfully.")
#     |> redirect(to: Routes.retro_session_path(conn, :index))
#   end
end
