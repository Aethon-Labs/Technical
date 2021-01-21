defmodule Friends.MixProject do
  use Mix.Project

  def project do
    [
      app: :friends,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Friends.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:myxql, "~> 0.4.0"},

      # TEST
      {:ex_machina, "~> 2.2", only: :test},
    ]
  end
end
