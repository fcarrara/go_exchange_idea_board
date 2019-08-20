defmodule GoExchangeIdeaBoard.Repo do
  use Ecto.Repo,
    otp_app: :go_exchange_idea_board,
    adapter: Ecto.Adapters.Postgres
end
