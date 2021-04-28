defmodule GoExchangeIdeaBoardWeb.ActionItemControllerTest do
  use GoExchangeIdeaBoardWeb.ConnCase

  alias GoExchangeIdeaBoard.Retrospectives.{ActionItems, RetroSessions}

  def fixture(:action_item) do
    {:ok, retro_session} = RetroSessions.create_retro_session(%{date: ~N[2010-04-17 14:00:00]})

    create_attrs = %{retro_session_id: retro_session.id, completed: true, content: "some content"}
    {:ok, action_item} = ActionItems.create_action_item(create_attrs)
    action_item
  end

  describe "index" do
    test "lists all action_items", %{conn: conn} do
      conn = get(conn, Routes.action_item_path(conn, :index))
      assert html_response(conn, 200) =~ "Action Items"
    end
  end

  describe "new action_item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.action_item_path(conn, :new))
      assert html_response(conn, 200) =~ "Create action item"
    end
  end

  describe "edit action_item" do
    setup [:create_action_item]

    test "renders form for editing chosen action_item", %{conn: conn, action_item: action_item} do
      conn = get(conn, Routes.action_item_path(conn, :edit, action_item))
      assert html_response(conn, 200) =~ "Action Item"
    end
  end

  defp create_action_item(_) do
    action_item = fixture(:action_item)
    {:ok, action_item: action_item}
  end
end
