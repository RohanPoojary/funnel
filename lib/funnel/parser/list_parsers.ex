defmodule Funnel.Parser.ListParsers do
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
