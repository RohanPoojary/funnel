defmodule Funnel.Parser.AtomParsers do
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
