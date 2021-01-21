{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.start(timeout: 30_000)

Ecto.Adapters.SQL.Sandbox.mode(Friends.Repo, :manual)
