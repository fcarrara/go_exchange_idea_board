defmodule GoExchangeIdeaBoardWeb.RetroSessionControllerTest do
  use GoExchangeIdeaBoardWeb.ConnCase

  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormats, RetroSessions}

  def fixture(:retro_session) do
    {:ok, retro_format} =
      RetroFormats.create_retro_format(%{
        name: "some name",
        retro_format_columns: [%{column_title: "some title", color: "blue"}]
      })

    {:ok, retro_session} =
      RetroSessions.create_retro_session(%{
        date: ~N[2010-04-17 14:00:00],
        retro_format_id: retro_format.id
      })

    retro_session
  end

  describe "index" do
    test "lists all retro sessions", %{conn: conn} do
      conn = get(conn, Routes.retro_session_path(conn, :index))
      assert html_response(conn, 200) =~ "Retro sessions"
    end
  end

  describe "new retro session" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.retro_session_path(conn, :new))
      assert html_response(conn, 200) =~ "Create retro session"
    end
  end

  describe "show retro_session" do
    setup [:create_retro_session]

    test "renders the retro session selected", %{
      conn: conn,
      retro_session: retro_session
    } do
      conn = get(conn, Routes.retro_session_path(conn, :show, retro_session))
      assert html_response(conn, 200) =~ "Retro session"
    end
  end

  defp create_retro_session(_) do
    retro_session = fixture(:retro_session)
    {:ok, retro_session: retro_session}
  end
end
