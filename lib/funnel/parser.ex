defmodule Funnel.Parser do

  use Funnel.Parser.AtomParsers
  use Funnel.Parser.PropertyParsers
  use Funnel.Parser.LogicalParsers
  use Funnel.Parser.ListParsers

  def parse(_value, []) do
    true
  end

  def parse(value, compare) do
      value == compare
  end
end
