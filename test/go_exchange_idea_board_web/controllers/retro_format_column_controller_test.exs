defmodule GoExchangeIdeaBoardWeb.RetroFormatColumnControllerTest do
  use GoExchangeIdeaBoardWeb.ConnCase

  alias GoExchangeIdeaBoard.Retrospectives

  @create_attrs %{column_title: "some column_title"}
  @update_attrs %{column_title: "some updated column_title"}
  @invalid_attrs %{column_title: nil}

  def fixture(:retro_format_column) do
    {:ok, retro_format_column} = Retrospectives.create_retro_format_column(@create_attrs)
    retro_format_column
  end

  describe "index" do
    test "lists all retro_format_columns", %{conn: conn} do
      conn = get(conn, Routes.retro_format_column_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Retro format columns"
    end
  end

  describe "new retro_format_column" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.retro_format_column_path(conn, :new))
      assert html_response(conn, 200) =~ "New Retro format column"
    end
  end

  describe "create retro_format_column" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.retro_format_column_path(conn, :create),
          retro_format_column: @create_attrs
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.retro_format_column_path(conn, :show, id)

      conn = get(conn, Routes.retro_format_column_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Retro format column"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.retro_format_column_path(conn, :create),
          retro_format_column: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "New Retro format column"
    end
  end

  describe "edit retro_format_column" do
    setup [:create_retro_format_column]

    test "renders form for editing chosen retro_format_column", %{
      conn: conn,
      retro_format_column: retro_format_column
    } do
      conn = get(conn, Routes.retro_format_column_path(conn, :edit, retro_format_column))
      assert html_response(conn, 200) =~ "Edit Retro format column"
    end
  end

  describe "update retro_format_column" do
    setup [:create_retro_format_column]

    test "redirects when data is valid", %{conn: conn, retro_format_column: retro_format_column} do
      conn =
        put(conn, Routes.retro_format_column_path(conn, :update, retro_format_column),
          retro_format_column: @update_attrs
        )

      assert redirected_to(conn) ==
               Routes.retro_format_column_path(conn, :show, retro_format_column)

      conn = get(conn, Routes.retro_format_column_path(conn, :show, retro_format_column))
      assert html_response(conn, 200) =~ "some updated column_title"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      retro_format_column: retro_format_column
    } do
      conn =
        put(conn, Routes.retro_format_column_path(conn, :update, retro_format_column),
          retro_format_column: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Retro format column"
    end
  end

  describe "delete retro_format_column" do
    setup [:create_retro_format_column]

    test "deletes chosen retro_format_column", %{
      conn: conn,
      retro_format_column: retro_format_column
    } do
      conn = delete(conn, Routes.retro_format_column_path(conn, :delete, retro_format_column))
      assert redirected_to(conn) == Routes.retro_format_column_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.retro_format_column_path(conn, :show, retro_format_column))
      end
    end
  end

  defp create_retro_format_column(_) do
    retro_format_column = fixture(:retro_format_column)
    {:ok, retro_format_column: retro_format_column}
  end
end
