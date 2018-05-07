defmodule Funnel.Parser.LogicalParsers do
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

      def parse(value, [{:ne, compare} | rest]) do
        value != compare and parse(value, rest)
      end
    end
  end
end
