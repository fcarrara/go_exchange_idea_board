defmodule GoExchangeIdeaBoard.Retrospectives.RetroSessions do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.{EventCenter, Repo}
  alias GoExchangeIdeaBoard.Retrospectives.{Note, RetroSession}

  def list_retro_sessions do
    RetroSession
    |> preload(:retro_format)
    |> preload(:action_items)
    |> preload(:notes)
    |> Repo.all()
  end

  def get_retro_session!(id), do: Repo.get!(RetroSession, id)

  def get_whole_session(id) do
    notes = from n in Note, where: [retro_session_id: ^id]

    RetroSession
    |> where(id: ^id)
    |> join(:left, [rs], _ in assoc(rs, :retro_format))
    |> join(:left, [_, rf], _ in assoc(rf, :retro_format_columns))
    |> join(:left, [_, _, rfc], n in ^notes, on: rfc.id == n.retro_format_column_id)
    |> order_by([_, _, rfc, n], asc: rfc.id, asc: n.id)
    |> preload([_, rf, rfc, n], retro_format: {rf, retro_format_columns: {rfc, notes: n}})
    |> Repo.one!()
  end

  def create_retro_session(attrs \\ %{}) do
    %RetroSession{}
    |> RetroSession.changeset(attrs)
    |> Repo.insert()
    |> EventCenter.broadcast_change([:retro_session, :created])
  end

  def update_retro_session(%RetroSession{} = retro_session, attrs) do
    retro_session
    |> RetroSession.changeset(attrs)
    |> Repo.update()
    |> EventCenter.broadcast_change([:retro_session, :updated])
  end

  def delete_retro_session(%RetroSession{} = retro_session) do
    retro_session
    |> Repo.delete()
    |> EventCenter.broadcast_change([:retro_session, :deleted])
  end

  def change_retro_session(%RetroSession{} = retro_session, attrs \\ %{}) do
    RetroSession.changeset(retro_session, attrs)
  end
end
