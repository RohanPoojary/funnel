defmodule Funnel.Query do

  alias Funnel.Parser

  def process(document, [{name, value} | rest]) do
    Map.get(document, name)
    |> parse(value)
    |> case do
      true -> process(document, rest)
      false -> false
    end
  end

  def process(_document, []) do
    true
  end

  defp parse(value, compare) when is_list(compare) and is_map(value) do
    process(value, compare)
  end

  defp parse(value, compare) do
    Parser.parse(value, compare)
  end
end
