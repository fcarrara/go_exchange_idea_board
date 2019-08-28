defmodule GoExchangeIdeaBoard.RetroFormatsTest do
  use GoExchangeIdeaBoard.DataCase

  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormat, RetroFormats}

  @valid_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def retro_format_fixture(attrs \\ %{}) do
    {:ok, retro_format} =
      attrs
      |> Enum.into(@valid_attrs)
      |> RetroFormats.create_retro_format()

    retro_format
  end

  test "list_retro_formats/0 returns all retro_formats" do
    retro_format = retro_format_fixture()
    assert RetroFormats.list_retro_formats() == [retro_format]
  end

  test "get_retro_format!/1 returns the retro_format with given id" do
    retro_format = retro_format_fixture()
    assert RetroFormats.get_retro_format!(retro_format.id) == retro_format
  end

  test "create_retro_format/1 with valid data creates a retro_format" do
    assert {:ok, %RetroFormat{} = retro_format} = RetroFormats.create_retro_format(@valid_attrs)

    assert retro_format.name == "some name"
  end

  test "create_retro_format/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = RetroFormats.create_retro_format(@invalid_attrs)
  end

  test "update_retro_format/2 with valid data updates the retro_format" do
    retro_format = retro_format_fixture()

    assert {:ok, %RetroFormat{} = retro_format} =
             RetroFormats.update_retro_format(retro_format, @update_attrs)

    assert retro_format.name == "some updated name"
  end

  test "update_retro_format/2 with invalid data returns error changeset" do
    retro_format = retro_format_fixture()

    assert {:error, %Ecto.Changeset{}} =
             RetroFormats.update_retro_format(retro_format, @invalid_attrs)

    assert retro_format == RetroFormats.get_retro_format!(retro_format.id)
  end

  test "delete_retro_format/1 deletes the retro_format" do
    retro_format = retro_format_fixture()
    assert {:ok, %RetroFormat{}} = RetroFormats.delete_retro_format(retro_format)

    assert_raise Ecto.NoResultsError, fn ->
      RetroFormats.get_retro_format!(retro_format.id)
    end
  end

  test "change_retro_format/1 returns a retro_format changeset" do
    retro_format = retro_format_fixture()
    assert %Ecto.Changeset{} = RetroFormats.change_retro_format(retro_format)
  end
end
