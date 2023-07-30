defmodule RatioCalc.MixProject do
  use Mix.Project

  def project do
    [
      app: :ratio_calc,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {RatioCalc.Supervisor, []}
    ]
  end

  defp deps do
    [
      {:exsync, "~> 0.2", only: :dev},
    ]
  end
end
