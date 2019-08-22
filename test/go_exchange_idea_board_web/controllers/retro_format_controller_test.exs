defmodule GoExchangeIdeaBoardWeb.RetroFormatControllerTest do
  use GoExchangeIdeaBoardWeb.ConnCase

  alias GoExchangeIdeaBoard.Retrospectives

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:retro_format) do
    {:ok, retro_format} = Retrospectives.create_retro_format(@create_attrs)
    retro_format
  end

  describe "index" do
    test "lists all retro_formats", %{conn: conn} do
      conn = get(conn, Routes.retro_format_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Retro formats"
    end
  end

  describe "new retro_format" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.retro_format_path(conn, :new))
      assert html_response(conn, 200) =~ "New Retro format"
    end
  end

  describe "create retro_format" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.retro_format_path(conn, :create), retro_format: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.retro_format_path(conn, :show, id)

      conn = get(conn, Routes.retro_format_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Retro format"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.retro_format_path(conn, :create), retro_format: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Retro format"
    end
  end

  describe "edit retro_format" do
    setup [:create_retro_format]

    test "renders form for editing chosen retro_format", %{conn: conn, retro_format: retro_format} do
      conn = get(conn, Routes.retro_format_path(conn, :edit, retro_format))
      assert html_response(conn, 200) =~ "Edit Retro format"
    end
  end

  describe "update retro_format" do
    setup [:create_retro_format]

    test "redirects when data is valid", %{conn: conn, retro_format: retro_format} do
      conn =
        put(conn, Routes.retro_format_path(conn, :update, retro_format),
          retro_format: @update_attrs
        )

      assert redirected_to(conn) == Routes.retro_format_path(conn, :show, retro_format)

      conn = get(conn, Routes.retro_format_path(conn, :show, retro_format))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, retro_format: retro_format} do
      conn =
        put(conn, Routes.retro_format_path(conn, :update, retro_format),
          retro_format: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Retro format"
    end
  end

  describe "delete retro_format" do
    setup [:create_retro_format]

    test "deletes chosen retro_format", %{conn: conn, retro_format: retro_format} do
      conn = delete(conn, Routes.retro_format_path(conn, :delete, retro_format))
      assert redirected_to(conn) == Routes.retro_format_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.retro_format_path(conn, :show, retro_format))
      end
    end
  end

  defp create_retro_format(_) do
    retro_format = fixture(:retro_format)
    {:ok, retro_format: retro_format}
  end
end
