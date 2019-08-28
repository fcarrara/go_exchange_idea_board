defmodule GoExchangeIdeaBoard.ActionItemsTest do
  use GoExchangeIdeaBoard.DataCase

  alias GoExchangeIdeaBoard.Retrospectives.{ActionItem, ActionItems}

  @valid_attrs %{completed: true, content: "some content"}
  @update_attrs %{completed: false, content: "some updated content"}
  @invalid_attrs %{completed: nil, content: nil}

  def action_item_fixture(attrs \\ %{}) do
    {:ok, action_item} =
      attrs
      |> Enum.into(@valid_attrs)
      |> ActionItems.create_action_item()

    action_item
  end

  test "list_action_items/0 returns all action_items" do
    action_item = action_item_fixture()
    assert ActionItems.list_action_items() == [action_item]
  end

  test "get_action_item!/1 returns the action_item with given id" do
    action_item = action_item_fixture()
    assert ActionItems.get_action_item!(action_item.id) == action_item
  end

  test "create_action_item/1 with valid data creates a action_item" do
    assert {:ok, %ActionItem{} = action_item} = ActionItems.create_action_item(@valid_attrs)
    assert action_item.completed == true
    assert action_item.content == "some content"
  end

  test "create_action_item/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ActionItems.create_action_item(@invalid_attrs)
  end

  test "update_action_item/2 with valid data updates the action_item" do
    action_item = action_item_fixture()

    assert {:ok, %ActionItem{} = action_item} =
             ActionItems.update_action_item(action_item, @update_attrs)

    assert action_item.completed == false
    assert action_item.content == "some updated content"
  end

  test "update_action_item/2 with invalid data returns error changeset" do
    action_item = action_item_fixture()

    assert {:error, %Ecto.Changeset{}} =
             ActionItems.update_action_item(action_item, @invalid_attrs)

    assert action_item == ActionItems.get_action_item!(action_item.id)
  end

  test "delete_action_item/1 deletes the action_item" do
    action_item = action_item_fixture()
    assert {:ok, %ActionItem{}} = ActionItems.delete_action_item(action_item)
    assert_raise Ecto.NoResultsError, fn -> ActionItems.get_action_item!(action_item.id) end
  end

  test "change_action_item/1 returns a action_item changeset" do
    action_item = action_item_fixture()
    assert %Ecto.Changeset{} = ActionItems.change_action_item(action_item)
  end
end
