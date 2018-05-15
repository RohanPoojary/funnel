defmodule Funnel.Parser.PropertyParser do
  @moduledoc ~S"""
  It provides `parse` functions that handles property based operations like length
  and Regex matches.

  This a special parser where the value is passed on to next parser. Hence only parsers
  for regular expressions work when imported, rest need other parsers to be imported.


  ## Examples

      iex> defmodule Parser do
      ...>  use Funnel.Parser.PropertyParser
      ...> end
      iex> Parser.parse('abc123', ~r'^\d.*') # Regex matches a string that starts with digit
      false
      iex> Parser.parse(1.45, gt: 1)
      ** (FunctionClauseError) no function clause matching in Funnel.Parser.PropertyParserTest.Parser.parse/2

  """

  defmacro __using__(_opts) do
    quote do
      def parse(value, [{:len, compare} | rest]) when is_bitstring(value) do
        parse(String.length(value), compare) and parse(value, rest)
      end

      def parse(value, [{:len, compare} | rest]) when is_list(value) do
        parse(length(value), compare) and parse(value, rest)
      end

      def parse(value, [{:len, compare} | rest]) do
        false
      end

      def parse(value, %Regex{} = pattern) when is_bitstring(value) do
        Regex.match?(pattern, value)
      end

      def parse(value, %Regex{} = pattern) when is_integer(value) do
        Regex.match?(pattern, Integer.to_string(value))
      end

      def parse(value, %Regex{} = pattern) when is_float(value) do
        Regex.match?(pattern, Float.to_string(value))
      end

      def parse(value, %Regex{} = pattern) when is_list(value) do
        Regex.match?(pattern, List.to_string(value))
      end
    end
  end
end
