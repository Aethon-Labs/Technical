use Mix.Config

config :hang_out,
  ecto_repos: [HangOut.Repo]

config :hang_out, HangOutWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5INw4VhAk0Kgt18Xtgj4zjQgkQer2FgIXEnVgOpDPe0OwQ4rlH7ITWL+OjP5ZfiR",
  render_errors: [view: HangOutWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HangOut.PubSub,
  live_view: [signing_salt: "ohQ/44bj"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
