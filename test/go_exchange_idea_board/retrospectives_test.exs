defmodule GoExchangeIdeaBoard.RetrospectivesTest do
  use GoExchangeIdeaBoard.DataCase

  alias GoExchangeIdeaBoard.Retrospectives

  describe "retro_formats" do
    alias GoExchangeIdeaBoard.Retrospectives.RetroFormat

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def retro_format_fixture(attrs \\ %{}) do
      {:ok, retro_format} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_retro_format()

      retro_format
    end

    test "list_retro_formats/0 returns all retro_formats" do
      retro_format = retro_format_fixture()
      assert Retrospectives.list_retro_formats() == [retro_format]
    end

    test "get_retro_format!/1 returns the retro_format with given id" do
      retro_format = retro_format_fixture()
      assert Retrospectives.get_retro_format!(retro_format.id) == retro_format
    end

    test "create_retro_format/1 with valid data creates a retro_format" do
      assert {:ok, %RetroFormat{} = retro_format} =
               Retrospectives.create_retro_format(@valid_attrs)

      assert retro_format.name == "some name"
    end

    test "create_retro_format/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Retrospectives.create_retro_format(@invalid_attrs)
    end

    test "update_retro_format/2 with valid data updates the retro_format" do
      retro_format = retro_format_fixture()

      assert {:ok, %RetroFormat{} = retro_format} =
               Retrospectives.update_retro_format(retro_format, @update_attrs)

      assert retro_format.name == "some updated name"
    end

    test "update_retro_format/2 with invalid data returns error changeset" do
      retro_format = retro_format_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.update_retro_format(retro_format, @invalid_attrs)

      assert retro_format == Retrospectives.get_retro_format!(retro_format.id)
    end

    test "delete_retro_format/1 deletes the retro_format" do
      retro_format = retro_format_fixture()
      assert {:ok, %RetroFormat{}} = Retrospectives.delete_retro_format(retro_format)

      assert_raise Ecto.NoResultsError, fn ->
        Retrospectives.get_retro_format!(retro_format.id)
      end
    end

    test "change_retro_format/1 returns a retro_format changeset" do
      retro_format = retro_format_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_retro_format(retro_format)
    end
  end

  describe "retro_format_columns" do
    alias GoExchangeIdeaBoard.Retrospectives.RetroFormatColumn

    @valid_attrs %{column_title: "some column_title"}
    @update_attrs %{column_title: "some updated column_title"}
    @invalid_attrs %{column_title: nil}

    def retro_format_column_fixture(attrs \\ %{}) do
      {:ok, retro_format_column} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_retro_format_column()

      retro_format_column
    end

    test "list_retro_format_columns/0 returns all retro_format_columns" do
      retro_format_column = retro_format_column_fixture()
      assert Retrospectives.list_retro_format_columns() == [retro_format_column]
    end

    test "get_retro_format_column!/1 returns the retro_format_column with given id" do
      retro_format_column = retro_format_column_fixture()

      assert Retrospectives.get_retro_format_column!(retro_format_column.id) ==
               retro_format_column
    end

    test "create_retro_format_column/1 with valid data creates a retro_format_column" do
      assert {:ok, %RetroFormatColumn{} = retro_format_column} =
               Retrospectives.create_retro_format_column(@valid_attrs)

      assert retro_format_column.column_title == "some column_title"
    end

    test "create_retro_format_column/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.create_retro_format_column(@invalid_attrs)
    end

    test "update_retro_format_column/2 with valid data updates the retro_format_column" do
      retro_format_column = retro_format_column_fixture()

      assert {:ok, %RetroFormatColumn{} = retro_format_column} =
               Retrospectives.update_retro_format_column(retro_format_column, @update_attrs)

      assert retro_format_column.column_title == "some updated column_title"
    end

    test "update_retro_format_column/2 with invalid data returns error changeset" do
      retro_format_column = retro_format_column_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.update_retro_format_column(retro_format_column, @invalid_attrs)

      assert retro_format_column ==
               Retrospectives.get_retro_format_column!(retro_format_column.id)
    end

    test "delete_retro_format_column/1 deletes the retro_format_column" do
      retro_format_column = retro_format_column_fixture()

      assert {:ok, %RetroFormatColumn{}} =
               Retrospectives.delete_retro_format_column(retro_format_column)

      assert_raise Ecto.NoResultsError, fn ->
        Retrospectives.get_retro_format_column!(retro_format_column.id)
      end
    end

    test "change_retro_format_column/1 returns a retro_format_column changeset" do
      retro_format_column = retro_format_column_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_retro_format_column(retro_format_column)
    end
  end

  describe "retro_sessions" do
    alias GoExchangeIdeaBoard.Retrospectives.RetroSession

    @valid_attrs %{date: ~N[2010-04-17 14:00:00]}
    @update_attrs %{date: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{date: nil}

    def retro_session_fixture(attrs \\ %{}) do
      {:ok, retro_session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_retro_session()

      retro_session
    end

    test "list_retro_sessions/0 returns all retro_sessions" do
      retro_session = retro_session_fixture()
      assert Retrospectives.list_retro_sessions() == [retro_session]
    end

    test "get_retro_session!/1 returns the retro_session with given id" do
      retro_session = retro_session_fixture()
      assert Retrospectives.get_retro_session!(retro_session.id) == retro_session
    end

    test "create_retro_session/1 with valid data creates a retro_session" do
      assert {:ok, %RetroSession{} = retro_session} =
               Retrospectives.create_retro_session(@valid_attrs)

      assert retro_session.date == ~N[2010-04-17 14:00:00]
    end

    test "create_retro_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Retrospectives.create_retro_session(@invalid_attrs)
    end

    test "update_retro_session/2 with valid data updates the retro_session" do
      retro_session = retro_session_fixture()

      assert {:ok, %RetroSession{} = retro_session} =
               Retrospectives.update_retro_session(retro_session, @update_attrs)

      assert retro_session.date == ~N[2011-05-18 15:01:01]
    end

    test "update_retro_session/2 with invalid data returns error changeset" do
      retro_session = retro_session_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.update_retro_session(retro_session, @invalid_attrs)

      assert retro_session == Retrospectives.get_retro_session!(retro_session.id)
    end

    test "delete_retro_session/1 deletes the retro_session" do
      retro_session = retro_session_fixture()
      assert {:ok, %RetroSession{}} = Retrospectives.delete_retro_session(retro_session)

      assert_raise Ecto.NoResultsError, fn ->
        Retrospectives.get_retro_session!(retro_session.id)
      end
    end

    test "change_retro_session/1 returns a retro_session changeset" do
      retro_session = retro_session_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_retro_session(retro_session)
    end
  end

  describe "notes" do
    alias GoExchangeIdeaBoard.Retrospectives.Note

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Retrospectives.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Retrospectives.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Retrospectives.create_note(@valid_attrs)
      assert note.content == "some content"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Retrospectives.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, %Note{} = note} = Retrospectives.update_note(note, @update_attrs)
      assert note.content == "some updated content"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Retrospectives.update_note(note, @invalid_attrs)
      assert note == Retrospectives.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Retrospectives.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Retrospectives.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_note(note)
    end
  end

  describe "action_items" do
    alias GoExchangeIdeaBoard.Retrospectives.ActionItem

    @valid_attrs %{completed: true, content: "some content"}
    @update_attrs %{completed: false, content: "some updated content"}
    @invalid_attrs %{completed: nil, content: nil}

    def action_item_fixture(attrs \\ %{}) do
      {:ok, action_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Retrospectives.create_action_item()

      action_item
    end

    test "list_action_items/0 returns all action_items" do
      action_item = action_item_fixture()
      assert Retrospectives.list_action_items() == [action_item]
    end

    test "get_action_item!/1 returns the action_item with given id" do
      action_item = action_item_fixture()
      assert Retrospectives.get_action_item!(action_item.id) == action_item
    end

    test "create_action_item/1 with valid data creates a action_item" do
      assert {:ok, %ActionItem{} = action_item} = Retrospectives.create_action_item(@valid_attrs)
      assert action_item.completed == true
      assert action_item.content == "some content"
    end

    test "create_action_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Retrospectives.create_action_item(@invalid_attrs)
    end

    test "update_action_item/2 with valid data updates the action_item" do
      action_item = action_item_fixture()

      assert {:ok, %ActionItem{} = action_item} =
               Retrospectives.update_action_item(action_item, @update_attrs)

      assert action_item.completed == false
      assert action_item.content == "some updated content"
    end

    test "update_action_item/2 with invalid data returns error changeset" do
      action_item = action_item_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Retrospectives.update_action_item(action_item, @invalid_attrs)

      assert action_item == Retrospectives.get_action_item!(action_item.id)
    end

    test "delete_action_item/1 deletes the action_item" do
      action_item = action_item_fixture()
      assert {:ok, %ActionItem{}} = Retrospectives.delete_action_item(action_item)
      assert_raise Ecto.NoResultsError, fn -> Retrospectives.get_action_item!(action_item.id) end
    end

    test "change_action_item/1 returns a action_item changeset" do
      action_item = action_item_fixture()
      assert %Ecto.Changeset{} = Retrospectives.change_action_item(action_item)
    end
  end
end
