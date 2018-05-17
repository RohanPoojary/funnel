defmodule Membrane.MixProject do
  use Mix.Project

  @version "0.1.0-rc.0"

  def project do
    [
      app: :membrane,
      version: @version,
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      description: "A wrapper for filtering list of data",
      package: package(),

      # Docs
      name: "Membrane",
      docs: docs()
    ]
  end

  defp package do
    [
      maintainers: ["Rohan Poojary"],
      licenses: ["MIT"],
      links: %{"Github"=> "http://hexdocs.pm/RohanPoojary/Membrane"},
      files: ~w(.formatter.exs mix.exs README.md  lib test)
    ]
  end

  defp docs do
    [
      main: "Membrane",
      source_ref: "v#{@version}",
      source_url: "https://github.com/RohanPoojary/Membrane",
      extras: ["README.md"],
      groups_for_modules: [
        # Membrane,
        "Query": [
          Membrane.Query
        ],
        "Parsers": [
          Membrane.Parser,
          Membrane.Parser.AtomParser,
          Membrane.Parser.ListParser,
          Membrane.Parser.LogicalParser,
          Membrane.Parser.PropertyParser
        ]
      ]
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
      {:ex_doc, "~> 0.17", only: :docs},
      {:inch_ex, only: :docs}
    ]
  end
end
