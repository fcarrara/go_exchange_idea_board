defmodule GoExchangeIdeaBoard.EventCenter do
  alias Phoenix.PubSub

  @pubsub GoExchangeIdeaBoard.EventCenter.PubSub

  def subscribe() do
    PubSub.subscribe(@pubsub, topic())
  end

  def broadcast_change({:ok, result}, event) do
    PubSub.broadcast(@pubsub, topic(), {__MODULE__, event, result})

    {:ok, result}
  end

  def broadcast_change({:error, result}, _event) do
    {:error, result}
  end

  def topic do
    Atom.to_string(__MODULE__)
  end
end
