defmodule Doujind.MixProject do
  use Mix.Project

  def project do
    [
      app: :doujind,
      version: "0.1.0",
      elixir: "~> 1.6",
      escript: escript,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, "~> 3.1.0"},
      {:floki, "~> 0.20.0"},
      {:download, "~> 0.0.4"}
    ]
  end

  def escript, do: [main_module: Doujind]
end
