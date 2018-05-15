defmodule Membrane.Parser do
  @moduledoc ~S"""
    This is an aggregate module that uses all the parsers and handles fallback value.

    It imports all the 4 parsers:

    * `Membrane.Parser.AtomParser`
    * `Membrane.Parser.PropertyParser`
    * `Membrane.Parser.LogicalParser`
    * `Membrane.Parser.ListParser`

  """

  use Membrane.Parser.AtomParser
  use Membrane.Parser.PropertyParser
  use Membrane.Parser.LogicalParser
  use Membrane.Parser.ListParser

  @doc false
  def parse(_value, []) do
    true
  end

  def parse(value, compare) do
    value == compare
  end
end
