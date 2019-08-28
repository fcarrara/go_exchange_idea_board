# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :go_exchange_idea_board,
  ecto_repos: [GoExchangeIdeaBoard.Repo]

# Configures the endpoint
config :go_exchange_idea_board, GoExchangeIdeaBoardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3KG4jkDcCjNMDtu8/j5RsfnrhGRBTNdm4xHipz28zhxa+g/y/SB94D+zv40bgmT7",
  render_errors: [view: GoExchangeIdeaBoardWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GoExchangeIdeaBoard.EventCenter.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "aQDSuyxc2/eOtC2xTQfyiZ7j9FI3zALx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
