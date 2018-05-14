defmodule Funnel.Parser.LogicalParser do
  @moduledoc ~S"""
  Handles logical operations

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
