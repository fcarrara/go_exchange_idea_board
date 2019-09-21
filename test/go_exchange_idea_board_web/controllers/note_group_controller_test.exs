defmodule GoExchangeIdeaBoardWeb.NoteGroupControllerTest do
  use GoExchangeIdeaBoardWeb.ConnCase

  alias GoExchangeIdeaBoard.Retrospectives

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:note_group) do
    {:ok, note_group} = Retrospectives.create_note_group(@create_attrs)
    note_group
  end

  describe "index" do
    test "lists all note_groups", %{conn: conn} do
      conn = get(conn, Routes.note_group_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Note groups"
    end
  end

  describe "new note_group" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.note_group_path(conn, :new))
      assert html_response(conn, 200) =~ "New Note group"
    end
  end

  describe "create note_group" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.note_group_path(conn, :create), note_group: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.note_group_path(conn, :show, id)

      conn = get(conn, Routes.note_group_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Note group"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.note_group_path(conn, :create), note_group: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Note group"
    end
  end

  describe "edit note_group" do
    setup [:create_note_group]

    test "renders form for editing chosen note_group", %{conn: conn, note_group: note_group} do
      conn = get(conn, Routes.note_group_path(conn, :edit, note_group))
      assert html_response(conn, 200) =~ "Edit Note group"
    end
  end

  describe "update note_group" do
    setup [:create_note_group]

    test "redirects when data is valid", %{conn: conn, note_group: note_group} do
      conn = put(conn, Routes.note_group_path(conn, :update, note_group), note_group: @update_attrs)
      assert redirected_to(conn) == Routes.note_group_path(conn, :show, note_group)

      conn = get(conn, Routes.note_group_path(conn, :show, note_group))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, note_group: note_group} do
      conn = put(conn, Routes.note_group_path(conn, :update, note_group), note_group: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Note group"
    end
  end

  describe "delete note_group" do
    setup [:create_note_group]

    test "deletes chosen note_group", %{conn: conn, note_group: note_group} do
      conn = delete(conn, Routes.note_group_path(conn, :delete, note_group))
      assert redirected_to(conn) == Routes.note_group_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.note_group_path(conn, :show, note_group))
      end
    end
  end

  defp create_note_group(_) do
    note_group = fixture(:note_group)
    {:ok, note_group: note_group}
  end
end
