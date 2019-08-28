defmodule GoExchangeIdeaBoard.Retrospectives.RetroSessions do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.{EventCenter, Repo}
  alias GoExchangeIdeaBoard.Retrospectives.RetroSession

  def list_retro_sessions do
    Repo.all(RetroSession)
  end

  def get_retro_session!(id), do: Repo.get!(RetroSession, id)

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
