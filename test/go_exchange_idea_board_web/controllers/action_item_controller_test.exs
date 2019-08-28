defmodule GoExchangeIdeaBoardWeb.ActionItemControllerTest do
  use GoExchangeIdeaBoardWeb.ConnCase

  alias GoExchangeIdeaBoard.Retrospectives.ActionItems

  @create_attrs %{completed: true, content: "some content"}
  @update_attrs %{completed: false, content: "some updated content"}
  @invalid_attrs %{completed: nil, content: nil}

  def fixture(:action_item) do
    {:ok, action_item} = ActionItems.create_action_item(@create_attrs)
    action_item
  end

  describe "index" do
    test "lists all action_items", %{conn: conn} do
      conn = get(conn, Routes.action_item_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Action items"
    end
  end

  describe "new action_item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.action_item_path(conn, :new))
      assert html_response(conn, 200) =~ "New Action item"
    end
  end

  describe "create action_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.action_item_path(conn, :create), action_item: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.action_item_path(conn, :show, id)

      conn = get(conn, Routes.action_item_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Action item"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.action_item_path(conn, :create), action_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Action item"
    end
  end

  describe "edit action_item" do
    setup [:create_action_item]

    test "renders form for editing chosen action_item", %{conn: conn, action_item: action_item} do
      conn = get(conn, Routes.action_item_path(conn, :edit, action_item))
      assert html_response(conn, 200) =~ "Edit Action item"
    end
  end

  describe "update action_item" do
    setup [:create_action_item]

    test "redirects when data is valid", %{conn: conn, action_item: action_item} do
      conn =
        put(conn, Routes.action_item_path(conn, :update, action_item), action_item: @update_attrs)

      assert redirected_to(conn) == Routes.action_item_path(conn, :show, action_item)

      conn = get(conn, Routes.action_item_path(conn, :show, action_item))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, action_item: action_item} do
      conn =
        put(conn, Routes.action_item_path(conn, :update, action_item), action_item: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Action item"
    end
  end

  describe "delete action_item" do
    setup [:create_action_item]

    test "deletes chosen action_item", %{conn: conn, action_item: action_item} do
      conn = delete(conn, Routes.action_item_path(conn, :delete, action_item))
      assert redirected_to(conn) == Routes.action_item_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.action_item_path(conn, :show, action_item))
      end
    end
  end

  defp create_action_item(_) do
    action_item = fixture(:action_item)
    {:ok, action_item: action_item}
  end
end
