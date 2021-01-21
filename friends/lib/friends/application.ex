defmodule Friends.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Add Friends.Repo as a supervisor within the app's supervision tree.
      # This process will receive and execute queries. "Hey, I am the database guy."
      Friends.Repo
    ]

    opts = [strategy: :one_for_one, name: Friends.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
