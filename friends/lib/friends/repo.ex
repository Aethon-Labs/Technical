defmodule Friends.Repo do
  use Ecto.Repo,
    # Tell Ecto where to find database config info
    otp_app: :friends,
    # Ecto --> MyXQL Adapter --> myxql here --> MySQL Database
    adapter: Ecto.Adapters.MyXQL
end
