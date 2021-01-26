use Mix.Config

config :hang_out, HangOut.Repo,
  username: "root",
  password: "password",
  database: "hang_out_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :hang_out, HangOutWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
