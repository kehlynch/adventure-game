# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ag, ecto_repos: [Ag.Repo]

# Configures the endpoint
config :ag, AgWeb.Endpoint,
  url: [host: "localhost"],
  # This is used in dev and test environments
  secret_key_base: "uwySzv60GgmHISk0+1CM3nLwAe/XB77xZGle0ct/+DKucY2a+RvPW/MTRQVB1lvG",
  render_errors: [view: AgWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ag.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
