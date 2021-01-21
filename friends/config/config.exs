use Mix.Config

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "root",
  password: "password",
  hostname: "localhost"

config :friends, ecto_repos: [Friends.Repo]

import_config "#{Mix.env()}.exs"
