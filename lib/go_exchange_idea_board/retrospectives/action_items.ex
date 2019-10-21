defmodule GoExchangeIdeaBoard.Retrospectives.ActionItems do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.{EventCenter, Repo}
  alias GoExchangeIdeaBoard.Retrospectives.ActionItem

  def list_action_items do
    Repo.all(ActionItem)
  end

  def list_action_items(retro_session_id) do
    ActionItem
    |> where(retro_session_id: ^retro_session_id)
    |> Repo.all()
  end

  def get_action_item!(id), do: Repo.get!(ActionItem, id)

  def create_action_item(attrs \\ %{}) do
    %ActionItem{}
    |> ActionItem.changeset(attrs)
    |> Repo.insert()
    |> EventCenter.broadcast_change([:action_item, :created])
  end

  def update_action_item(%ActionItem{} = action_item, attrs) do
    action_item
    |> ActionItem.changeset(attrs)
    |> Repo.update()
    |> EventCenter.broadcast_change([:action_item, :updated])
  end

  def delete_action_item(%ActionItem{} = action_item) do
    action_item
    |> Repo.delete()
    |> EventCenter.broadcast_change([:action_item, :deleted])
  end

  def change_action_item(%ActionItem{} = action_item, attrs \\ %{}) do
    ActionItem.changeset(action_item, attrs)
  end
end
