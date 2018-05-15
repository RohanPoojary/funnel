defmodule Funnel.Parser.LogicalParser do
  @moduledoc ~S"""
  It provides `parse` functions that handles logical operations. To use this module a fallback
  method `parse(_value, [])` has to created.


  ## Examples

      iex> defmodule Parser do
      ...>  use Funnel.Parser.LogicalParser
      ...>  # A fallback parse has to be created.
      ...>  def parse(_value, []) do
      ...>    true
      ...>  end
      ...> end
      iex> Parser.parse(10, [gte: 8])
      true
      iex> Parser.parse(20, [eq: 2])
      false
      iex> Parser.parse(1.45, in: [1, 2, 3])
      ** (FunctionClauseError) no function clause matching in Funnel.Parser.LogicalParserTest.Parser.parse/2

  """

  defmacro __using__(_opts) do
    quote do
      def parse(value, [{:gt, compare} | rest]) do
        value > compare and parse(value, rest)
      end

      def parse(value, [{:lt, compare} | rest]) do
        value < compare and parse(value, rest)
      end

      def parse(value, [{:gte, compare} | rest]) do
        value >= compare and parse(value, rest)
      end

      def parse(value, [{:lte, compare} | rest]) do
        value <= compare and parse(value, rest)
      end

      def parse(value, [{:eq, compare} | rest]) do
        value == compare and parse(value, rest)
      end

      def parse(value, [{:neq, compare} | rest]) do
        value != compare and parse(value, rest)
      end
    end
  end
end
