defmodule Funnel.Parser.AtomParser do
  @moduledoc ~S"""
  It provides `parse` functions that handle `atom` parameters.


  ## Examples

      iex> defmodule Parser do
      ...>  use Funnel.Parser.AtomParser
      ...> end
      iex> Parser.parse("Hello", :number)
      false
      iex> Parser.parse(1.45, :number)
      true
      iex> Parser.parse(1.45, [gt: 1])
      ** (FunctionClauseError) no function clause matching in Funnel.Parser.AtomParserTest.Parser.parse/2

  """

  defmacro __using__(_opts) do
    quote do
      def parse(value, :exists) do
        !is_nil(value)
      end

      def parse(value, :notexists) do
        is_nil(value)
      end

      def parse(value, :integer) do
        is_integer(value)
      end

      def parse(value, :number) do
        is_number(value)
      end

      def parse(value, :float) do
        is_float(value)
      end

      def parse(value, :string) do
        is_bitstring(value)
      end

      def parse(value, :list) do
        is_list(value)
      end

      def parse(value, :map) do
        is_map(value)
      end

      def parse(nil, _args) do
        false
      end
    end
  end
end
