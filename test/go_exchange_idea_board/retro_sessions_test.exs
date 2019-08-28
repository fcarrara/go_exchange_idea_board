defmodule GoExchangeIdeaBoard.RetroSessionsTest do
  use GoExchangeIdeaBoard.DataCase

  alias GoExchangeIdeaBoard.Retrospectives.{RetroSession, RetroSessions}

  @valid_attrs %{date: ~N[2010-04-17 14:00:00]}
  @update_attrs %{date: ~N[2011-05-18 15:01:01]}
  @invalid_attrs %{date: nil}

  def retro_session_fixture(attrs \\ %{}) do
    {:ok, retro_session} =
      attrs
      |> Enum.into(@valid_attrs)
      |> RetroSessions.create_retro_session()

    retro_session
  end

  test "list_retro_sessions/0 returns all retro_sessions" do
    retro_session = retro_session_fixture()
    assert RetroSessions.list_retro_sessions() == [retro_session]
  end

  test "get_retro_session!/1 returns the retro_session with given id" do
    retro_session = retro_session_fixture()
    assert RetroSessions.get_retro_session!(retro_session.id) == retro_session
  end

  test "create_retro_session/1 with valid data creates a retro_session" do
    assert {:ok, %RetroSession{} = retro_session} =
             RetroSessions.create_retro_session(@valid_attrs)

    assert retro_session.date == ~N[2010-04-17 14:00:00]
  end

  test "create_retro_session/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = RetroSessions.create_retro_session(@invalid_attrs)
  end

  test "update_retro_session/2 with valid data updates the retro_session" do
    retro_session = retro_session_fixture()

    assert {:ok, %RetroSession{} = retro_session} =
             RetroSessions.update_retro_session(retro_session, @update_attrs)

    assert retro_session.date == ~N[2011-05-18 15:01:01]
  end

  test "update_retro_session/2 with invalid data returns error changeset" do
    retro_session = retro_session_fixture()

    assert {:error, %Ecto.Changeset{}} =
             RetroSessions.update_retro_session(retro_session, @invalid_attrs)

    assert retro_session == RetroSessions.get_retro_session!(retro_session.id)
  end

  test "delete_retro_session/1 deletes the retro_session" do
    retro_session = retro_session_fixture()
    assert {:ok, %RetroSession{}} = RetroSessions.delete_retro_session(retro_session)

    assert_raise Ecto.NoResultsError, fn ->
      RetroSessions.get_retro_session!(retro_session.id)
    end
  end

  test "change_retro_session/1 returns a retro_session changeset" do
    retro_session = retro_session_fixture()
    assert %Ecto.Changeset{} = RetroSessions.change_retro_session(retro_session)
  end
end
