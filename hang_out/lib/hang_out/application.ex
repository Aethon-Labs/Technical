defmodule HangOut.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      HangOut.Repo,
      # Start the Telemetry supervisor
      HangOutWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HangOut.PubSub},
      # Start the Endpoint (http/https)
      HangOutWeb.Endpoint
      # Start a worker by calling: HangOut.Worker.start_link(arg)
      # {HangOut.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HangOut.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HangOutWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
