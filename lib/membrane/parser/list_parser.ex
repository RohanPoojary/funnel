defmodule Membrane.Parser.ListParser do
  @moduledoc ~S"""
  It provides `parse` functions that handles list operations. To use this module a fallback
  method `parse(_value, [])` has to created.

  ## Examples

      iex> defmodule Parser do
      ...>  use Membrane.Parser.ListParser
      ...>  # A fallback parse has to be created.
      ...>  def parse(_value, []) do
      ...>    true
      ...>  end
      ...> end
      iex> Parser.parse(10, [in: [10, 20, 30]])
      true
      iex> Parser.parse([1, 2, 3], [nha: 2])
      false
      iex> Parser.parse(1.45, [gt: 1])
      ** (FunctionClauseError) no function clause matching in Membrane.Parser.ListParserTest.Parser.parse/2

  """

  defmacro __using__(_opts) do
    quote do
      def parse(value, [{:in, compare} | rest]) when is_list(compare) do
        Enum.member?(compare, value) and parse(value, rest)
      end

      def parse(value, [{:in, %Range{first: first, last: last}} | rest]) do
        value >= first and value <= last and parse(value, rest)
      end

      def parse(value, [{:nin, compare} | rest]) when is_list(compare) do
        !Enum.member?(compare, value) and parse(value, rest)
      end

      def parse(value, [{:nin, %Range{first: first, last: last}} | rest]) do
        (value < first or value > last) and parse(value, rest)
      end

      def parse(value, [{:has, compare} | rest] = arg) when is_list(value) do
        Enum.member?(value, compare) and parse(value, rest)
      end

      def parse(value, [{:nha, compare} | rest]) when is_list(value) do
        !Enum.member?(value, compare) and parse(value, rest)
      end
    end
  end
end
