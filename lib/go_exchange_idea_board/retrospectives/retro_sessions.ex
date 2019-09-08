defmodule GoExchangeIdeaBoard.Retrospectives.RetroSessions do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.{EventCenter, Repo}
  alias GoExchangeIdeaBoard.Retrospectives.{RetroFormat, RetroFormatColumn, RetroSession}

  def list_retro_sessions do
    Repo.all(RetroSession)
  end

  def get_retro_session!(id), do: Repo.get!(RetroSession, id)

  def get_retro_format_columns(id) do
    RetroSession
    |> where(id: ^id)
    |> join(:left, [rs], rf in RetroFormat, on: rs.retro_format_id == rf.id)
    |> join(:left, [_, rf], _ in assoc(rf, :retro_format_columns))
    |> join(:left, [_, _, rfc], _ in assoc(rfc, :notes))
    # |> preload([_, rf, rfc], [retro_formats: {rf, retro_format_columns: rfc}])
    |> select([_, _, rfc, n], %RetroFormatColumn{
      id: rfc.id,
      column_title: rfc.column_title,
      notes: %{id: n.id, content: n.content}
    })
    |> where([_,_,_,n], n.retro_session_id == ^id)
    |> Repo.all()
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
