defmodule GoExchangeIdeaBoardWeb.RetroSessionControllerTest do
  # use GoExchangeIdeaBoardWeb.ConnCase

  # alias GoExchangeIdeaBoard.Retrospectives

  # @create_attrs %{date: ~N[2010-04-17 14:00:00]}
  # @update_attrs %{date: ~N[2011-05-18 15:01:01]}
  # @invalid_attrs %{date: nil}

  # def fixture(:retro_session) do
  #   {:ok, retro_session} = Retrospectives.create_retro_session(@create_attrs)
  #   retro_session
  # end

  # describe "index" do
  #   test "lists all retro_sessions", %{conn: conn} do
  #     conn = get(conn, Routes.retro_session_path(conn, :index))
  #     assert html_response(conn, 200) =~ "Listing Retro sessions"
  #   end
  # end

  # describe "new retro_session" do
  #   test "renders form", %{conn: conn} do
  #     conn = get(conn, Routes.retro_session_path(conn, :new))
  #     assert html_response(conn, 200) =~ "New Retro session"
  #   end
  # end

  # describe "create retro_session" do
  #   test "redirects to show when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.retro_session_path(conn, :create), retro_session: @create_attrs)

  #     assert %{id: id} = redirected_params(conn)
  #     assert redirected_to(conn) == Routes.retro_session_path(conn, :show, id)

  #     conn = get(conn, Routes.retro_session_path(conn, :show, id))
  #     assert html_response(conn, 200) =~ "Show Retro session"
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.retro_session_path(conn, :create), retro_session: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "New Retro session"
  #   end
  # end

  # describe "edit retro_session" do
  #   setup [:create_retro_session]

  #   test "renders form for editing chosen retro_session", %{
  #     conn: conn,
  #     retro_session: retro_session
  #   } do
  #     conn = get(conn, Routes.retro_session_path(conn, :edit, retro_session))
  #     assert html_response(conn, 200) =~ "Edit Retro session"
  #   end
  # end

  # describe "update retro_session" do
  #   setup [:create_retro_session]

  #   test "redirects when data is valid", %{conn: conn, retro_session: retro_session} do
  #     conn =
  #       put(conn, Routes.retro_session_path(conn, :update, retro_session),
  #         retro_session: @update_attrs
  #       )

  #     assert redirected_to(conn) == Routes.retro_session_path(conn, :show, retro_session)

  #     conn = get(conn, Routes.retro_session_path(conn, :show, retro_session))
  #     assert html_response(conn, 200)
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, retro_session: retro_session} do
  #     conn =
  #       put(conn, Routes.retro_session_path(conn, :update, retro_session),
  #         retro_session: @invalid_attrs
  #       )

  #     assert html_response(conn, 200) =~ "Edit Retro session"
  #   end
  # end

  # describe "delete retro_session" do
  #   setup [:create_retro_session]

  #   test "deletes chosen retro_session", %{conn: conn, retro_session: retro_session} do
  #     conn = delete(conn, Routes.retro_session_path(conn, :delete, retro_session))
  #     assert redirected_to(conn) == Routes.retro_session_path(conn, :index)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.retro_session_path(conn, :show, retro_session))
  #     end
  #   end
  # end

  # defp create_retro_session(_) do
  #   retro_session = fixture(:retro_session)
  #   {:ok, retro_session: retro_session}
  # end
end
