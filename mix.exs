defmodule Funnel.MixProject do
  use Mix.Project

  @version "0.1.0-rc.0"

  def project do
    [
      app: :funnel,
      version: @version,
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      description: "A wrapper for filtering list of data",
      package: package(),

      # Docs
      name: "Funnel",
      docs: docs()
    ]
  end

  defp package do
    [
      maintainers: ["Rohan Poojary"],
      licenses: ["MIT"],
      links: %{"Github"=> "http://hexdocs.pm/RohanPoojary/Funnel"},
      files: ~w(.formatter.exs mix.exs README.md  lib test)
    ]
  end

  defp docs do
    [
      main: "Funnel",
      source_ref: "v#{@version}",
      source_url: "https://github.com/RohanPoojary/Funnel",
      extras: ["README.md"],
      groups_for_modules: [
        # Funnel,
        "Query": [
          Funnel.Query
        ],
        "Parsers": [
          Funnel.Parser,
          Funnel.Parser.AtomParser,
          Funnel.Parser.ListParser,
          Funnel.Parser.LogicalParser,
          Funnel.Parser.PropertyParser
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
      {:ex_doc, "~> 0.17", only: :docs}
    ]
  end
end
