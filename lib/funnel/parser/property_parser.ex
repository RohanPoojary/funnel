defmodule Funnel.Parser.PropertyParser do
  @moduledoc ~S"""
  Handles property based operations

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
