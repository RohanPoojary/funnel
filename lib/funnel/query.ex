defmodule Funnel.Query do
  @moduledoc ~S"""
  `Funnel.Query` module evaluates query against a map or struct. It evaluates every condition through
  `Funnel.Parser` module.

  ## Query Conditions
    The query conditions are divided into 4 types.

    * [Logical Conditions](#module-logical-conditions)
    * [Atom Conditions](#module-atom-conditions)
    * [Property Conditions](#module-property-conditions)
    * [List Conditions](#module-list-conditions)

  ### Logical Conditions
    These are conditions which are handled by `Funnel.Parser.LogicalParser` module.
    The condition will be of format `keyword: value`.

    | Keyword | Meaning |
    | ------- | ------- |
    | `:gt` | Greater than |
    | `:gte` | Greater than or equal to |
    | `:lt` | Lesser than |
    | `:lte` | Lesser than or equal to |
    | `:eq` | Equal to |
    | `:neq` | Not Equal to |

  ### Examples

      iex> data = %{a: 20, b: "hello", c: [1, 2, 3], d: %{e: 30}}
      iex> Funnel.Query.process(data, a: [gt: 10])
      true
      iex> Funnel.Query.process(data, a: [lt: 15])
      false
      # Underneath, its a simple greater or lesser operator
      # Hence it also supports strings or mixed types
      iex> Funnel.Query.process(data, b: [lt: "Hello"]) # => "hello" < "Hello"
      false
      iex> Funnel.Query.process(data, b: [gte: 5]) # => "hello" >= 5
      true
      # With multiple conditions
      iex> Funnel.Query.process(data, a: [lte: 20], c: [eq: [1, 2, 3]], d: [e: [gt: 20]])
      true

  ### Atom Conditions
    These are conditions which are handled by `Funnel.Parser.AtomParser` module.
    The condition will be of format `attribute: keyword`.

    | Keyword | Meaning |
    | ------- | ------- |
    | `:exists` | True if attribute exists |
    | `:notexists` | True if attribute does not exist |
    | `:integer` | True if the attrbute is an `integer` |
    | `:float` | True if the attrbute is a `float` |
    | `:number` | True if the attrbute is a `number` |
    | `:string` | True if the attrbute is a `string` |
    | `:list` | True if the attrbute is a `list` |
    | `:map` | True if the attrbute is a `map` |


  ### Examples

      iex> data = %{a: 20, b: "hello", c: [1, 2, 3], d: %{e: 30}}
      iex> Funnel.Query.process(data, a: :exists)
      true
      iex> Funnel.Query.process(data, d: [e: :notexists])
      false
      iex> Funnel.Query.process(data, b: :string)
      true
  
  ### Property Conditions
    These are conditions which are handled by `Funnel.Parser.PropertyParser` module.
    The condition will be of format `keyword: value | condition`.

    This also handles a `Regex` value. It returns `true` if the attribute's value matches with regex

    | Keyword | Meaning |
    | ------- | ------- |
    | `:len` | Length of the attribute should be equal to value, if condition is passed then evaluation is aginst its length |


  ### Examples

      iex> data = %{a: 20, b: "hello", c: [1, 2, 3], d: %{e: 30}}
      iex> Funnel.Query.process(data, c: [len: 3])
      true
      # Length against a number doesn't exist.
      iex> Funnel.Query.process(data, a: [len: 10])
      false
      # With Regex
      iex> Funnel.Query.process(data, b: ~r'\w+ll\w+')
      true
      # Internally a number is converted to a string, Hence regex works even against a number
      iex> Funnel.Query.process(data, d: [e: ~r'\d+'])
      true
  
  ### List Conditions
    These are conditions which are handled by `Funnel.Parser.ListParser` module.
    The condition will be of format `keyword: value`. In this condition either attribute's value
    or keyword's value has to be a list

    | Keyword | Meaning |
    | ------- | ------- |
    | `:in` | True if value of attribute is in keyword's value |
    | `:nin` | True if value of attribute is not in keyword's value |
    | `:has` | True if value of attribute has keyword's value |
    | `:nha` | True if value of attribute  does not have keyword's value |


  ### Examples

      iex> data = %{a: 20, b: "hello", c: [1, 2, 3], d: %{e: 30}}
      iex> Funnel.Query.process(data, a: [in: [10, 20, 30]])
      true
      iex> Funnel.Query.process(data, c: [has: 2])
      true
      iex> Funnel.Query.process(data, d: [e: [nin: [10, 20, 30]]])
      false

  """
  alias Funnel.Parser

  @doc ~S"""
  Evaluates the struct against a query and returns `true` or `false`.

  ## Examples
      
      iex> alias Funnel.Query
      Funnel.Query
      iex> document = %{a: 100, b: 20, c: -1, meta: %{creator: "max"}}
      %{a: 100, b: 20, c: -1, meta: %{creator: "max"}}
      iex> Query.process(document, a: :exists, meta: [creator: "max"])
      true
      iex> Query.process(document, a: :exists, c: [gt: 0])
      false

  """
  @spec process(map | struct, list) :: boolean
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
