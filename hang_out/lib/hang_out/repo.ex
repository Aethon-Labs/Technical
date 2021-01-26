defmodule HangOut.Repo do
  use Ecto.Repo,
    otp_app: :hang_out,
    adapter: Ecto.Adapters.MyXQL

  # adapter: Ecto.Adapters.Postgres
end
