use Mix.Config

# Configure your database
config :go_exchange_idea_board, GoExchangeIdeaBoard.Repo,
  username: "postgres",
  password: "postgres",
  database: "go_exchange_idea_board_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :go_exchange_idea_board, GoExchangeIdeaBoardWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
