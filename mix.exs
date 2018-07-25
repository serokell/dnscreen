defmodule DNScreen.MixProject do
  use Mix.Project

  def project do
    [
      app: :dnscreen,
      version: "0.0.0",
      deps: [
        {:cowboy, "~> 2.4.0"},
        {:httpoison, "~> 1.2.0"},
        {:plug, "~> 1.6.1"},
        {:poison, "~> 3.1"}
      ]
    ]
  end

  def application do
    [mod: {DNScreen, []}]
  end
end
