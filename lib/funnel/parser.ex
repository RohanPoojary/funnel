defmodule Funnel.Parser do
  @moduledoc ~S"""
    This is an aggregate module that uses all the parsers and handles fallback value.

    It imports all the 4 parsers:

    * `Funnel.Parser.AtomParser`
    * `Funnel.Parser.PropertyParser`
    * `Funnel.Parser.LogicalParser`
    * `Funnel.Parser.ListParser`

  """

  use Funnel.Parser.AtomParser
  use Funnel.Parser.PropertyParser
  use Funnel.Parser.LogicalParser
  use Funnel.Parser.ListParser

  @doc false
  def parse(_value, []) do
    true
  end

  def parse(value, compare) do
    value == compare
  end
end
