defmodule GoExchangeIdeaBoard.RetroFormatColumnsTest do
  use GoExchangeIdeaBoard.DataCase

  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormatColumn, RetroFormatColumns}

  @valid_attrs %{column_title: "some column_title"}
  @update_attrs %{column_title: "some updated column_title"}
  @invalid_attrs %{column_title: nil}

  def retro_format_column_fixture(attrs \\ %{}) do
    {:ok, retro_format_column} =
      attrs
      |> Enum.into(@valid_attrs)
      |> RetroFormatColumns.create_retro_format_column()

    retro_format_column
  end

  test "list_retro_format_columns/0 returns all retro_format_columns" do
    retro_format_column = retro_format_column_fixture()
    assert RetroFormatColumns.list_retro_format_columns() == [retro_format_column]
  end

  test "get_retro_format_column!/1 returns the retro_format_column with given id" do
    retro_format_column = retro_format_column_fixture()

    assert RetroFormatColumns.get_retro_format_column!(retro_format_column.id) ==
             retro_format_column
  end

  test "create_retro_format_column/1 with valid data creates a retro_format_column" do
    assert {:ok, %RetroFormatColumn{} = retro_format_column} =
             RetroFormatColumns.create_retro_format_column(@valid_attrs)

    assert retro_format_column.column_title == "some column_title"
  end

  test "create_retro_format_column/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} =
             RetroFormatColumns.create_retro_format_column(@invalid_attrs)
  end

  test "update_retro_format_column/2 with valid data updates the retro_format_column" do
    retro_format_column = retro_format_column_fixture()

    assert {:ok, %RetroFormatColumn{} = retro_format_column} =
             RetroFormatColumns.update_retro_format_column(retro_format_column, @update_attrs)

    assert retro_format_column.column_title == "some updated column_title"
  end

  test "update_retro_format_column/2 with invalid data returns error changeset" do
    retro_format_column = retro_format_column_fixture()

    assert {:error, %Ecto.Changeset{}} =
             RetroFormatColumns.update_retro_format_column(retro_format_column, @invalid_attrs)

    assert retro_format_column ==
             RetroFormatColumns.get_retro_format_column!(retro_format_column.id)
  end

  test "delete_retro_format_column/1 deletes the retro_format_column" do
    retro_format_column = retro_format_column_fixture()

    assert {:ok, %RetroFormatColumn{}} =
             RetroFormatColumns.delete_retro_format_column(retro_format_column)

    assert_raise Ecto.NoResultsError, fn ->
      RetroFormatColumns.get_retro_format_column!(retro_format_column.id)
    end
  end

  test "change_retro_format_column/1 returns a retro_format_column changeset" do
    retro_format_column = retro_format_column_fixture()
    assert %Ecto.Changeset{} = RetroFormatColumns.change_retro_format_column(retro_format_column)
  end
end
