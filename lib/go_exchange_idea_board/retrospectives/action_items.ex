defmodule GoExchangeIdeaBoard.Retrospectives.ActionItems do
  import Ecto.Query, warn: false

  alias GoExchangeIdeaBoard.Repo
  alias GoExchangeIdeaBoard.Retrospectives.ActionItem

  def list_action_items do
    Repo.all(ActionItem)
  end

  def get_action_item!(id), do: Repo.get!(ActionItem, id)

  def create_action_item(attrs \\ %{}) do
    %ActionItem{}
    |> ActionItem.changeset(attrs)
    |> Repo.insert()
  end

  def update_action_item(%ActionItem{} = action_item, attrs) do
    action_item
    |> ActionItem.changeset(attrs)
    |> Repo.update()
  end

  def delete_action_item(%ActionItem{} = action_item) do
    Repo.delete(action_item)
  end

  def change_action_item(%ActionItem{} = action_item) do
    ActionItem.changeset(action_item, %{})
  end
end
