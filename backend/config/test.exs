use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ag, AgWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ag, Ag.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "password",
  database: "ag_test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

config :ag, :basic_auth,
  username: "username",
  password: "password",
  realm: "CMS"
