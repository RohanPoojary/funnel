defmodule Membrane.Parser do
  @moduledoc ~S"""
    This is an aggregate module that uses all the parsers and handles fallback value.

    It imports all the 4 parsers:

    * `Membrane.Parser.AtomParser`
    * `Membrane.Parser.PropertyParser`
    * `Membrane.Parser.LogicalParser`
    * `Membrane.Parser.ListParser`

    It is not advisable to explicitly import individual parsers. This is because fallback
    functions has to be added. So you can directly use `Funnel.Query` module
    or use `Membrane.Parser` module as required.

  ## Examples

      iex> alias Membrane.Parser
      Membrane.Parser
      iex> Parser.parse(10, gt: 3)
      true
      iex> Parser.parse("hello", len: 6)
      false
      iex> Parser.parse([1, 2, 3], has: 3)
      true

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
