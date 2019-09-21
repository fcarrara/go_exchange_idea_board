defmodule GoExchangeIdeaBoard.RetrospectivesTest do
  use GoExchangeIdeaBoard.DataCase

  alias GoExchangeIdeaBoard.Retrospectives

  describe "note_groups" do
    alias GoExchangeIdeaBoard.Retrospectives.NoteGroup

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def note_group_fixture(attrs \\ %{}) do
      {:ok, note_group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_note_group()

      note_group
    end

    test "list_note_groups/0 returns all note_groups" do
      note_group = note_group_fixture()
      assert Retrospectives.list_note_groups() == [note_group]
    end

    test "get_note_group!/1 returns the note_group with given id" do
      note_group = note_group_fixture()
      assert Retrospectives.get_note_group!(note_group.id) == note_group
    end

    test "create_note_group/1 with valid data creates a note_group" do
      assert {:ok, %NoteGroup{} = note_group} = Retrospectives.create_note_group(@valid_attrs)
    end

    test "create_note_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Retrospectives.create_note_group(@invalid_attrs)
    end

    test "update_note_group/2 with valid data updates the note_group" do
      note_group = note_group_fixture()
      assert {:ok, %NoteGroup{} = note_group} = Retrospectives.update_note_group(note_group, @update_attrs)
    end

    test "update_note_group/2 with invalid data returns error changeset" do
      note_group = note_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Retrospectives.update_note_group(note_group, @invalid_attrs)
      assert note_group == Retrospectives.get_note_group!(note_group.id)
    end

    test "delete_note_group/1 deletes the note_group" do
      note_group = note_group_fixture()
      assert {:ok, %NoteGroup{}} = Retrospectives.delete_note_group(note_group)
      assert_raise Ecto.NoResultsError, fn -> Retrospectives.get_note_group!(note_group.id) end
    end

    test "change_note_group/1 returns a note_group changeset" do
      note_group = note_group_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_note_group(note_group)
    end
  end
end
