use Mix.Config

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "root",
  password: "password",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :friends, ecto_repos: [Friends.Repo]
