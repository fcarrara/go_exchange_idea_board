defmodule GoExchangeIdeaBoardWeb.RetroFormatControllerTest do
  use GoExchangeIdeaBoardWeb.ConnCase

  alias GoExchangeIdeaBoard.Retrospectives.RetroFormats

  @create_attrs %{
    name: "some name",
    retro_format_columns: [%{column_title: "some title", color: "blue"}]
  }

  def fixture(:retro_format) do
    {:ok, retro_format} = RetroFormats.create_retro_format(@create_attrs)

    retro_format
  end

  describe "index" do
    test "lists all retro_formats", %{conn: conn} do
      conn = get(conn, Routes.retro_format_path(conn, :index))
      assert html_response(conn, 200) =~ "Retro formats"
    end
  end

  describe "new retro_format" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.retro_format_path(conn, :new))
      assert html_response(conn, 200) =~ "Create retro format"
    end
  end

  describe "edit retro_format" do
    setup [:create_retro_format]

    test "renders form for editing chosen retro_format", %{conn: conn, retro_format: retro_format} do
      conn = get(conn, Routes.retro_format_path(conn, :edit, retro_format))
      assert html_response(conn, 200) =~ "Retro format"
    end
  end

  defp create_retro_format(_) do
    retro_format = fixture(:retro_format)

    {:ok, retro_format: retro_format}
  end
end
