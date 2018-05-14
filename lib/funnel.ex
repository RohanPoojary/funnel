defmodule Funnel do
  @moduledoc ~S"""
    Funnel provides a wrapper for filtering data with simplicity and efficiently.
    It filters out list of structs or maps that satisfies the query. The Query is inspired by
    Mongo, hence there's a lot of similarities.

  ## Installation

    Make sure elixir >= 1.6, then add following line to your `mix.exs` file

        def deps do
          ...
          [:funnel, "~> 0.1.0-rc.0"]
        end

    Run `mix deps.get` to install the package

  ## Query
        
    The examples below cover queries on exact, lesser than, greater than and nested comparision .
    To get in depth idea on query parameters that the module supports, please visit
    `Funnel.Query` module.

  ## Examples

    In the examples below, list of maps are used; But it can be list of structs or mix of both structs and maps.
    

      iex> data = [
      ...> %{id: 1, name: "Bob", action: "talk", age: 30},
      ...> %{id: 3, name: "Helen", action: "talk", age: 30},
      ...> %{id: 1, name: "Rocky",  action: "bark", age: 10},
      ...> %{id: 3, name: "Rocky",  action: "meow", age: 6},
      ...> %{id: 10, age: 3},
      ...> %{id: 1, type: "car", age: 12}
      ...> ]
      [
        %{action: "talk", age: 30, id: 1, name: "Bob"},
        %{action: "talk", age: 30, id: 3, name: "Helen"},
        %{action: "bark", age: 10, id: 1, name: "Rocky"},
        %{action: "meow", age: 6, id: 3, name: "Rocky"},
        %{age: 3, id: 10},
        %{age: 12, id: 1, type: "car"}
      ]
      ## Filters data with id = 1
      iex> Funnel.filter(data, id: 1)
      [
        %{age: 12, id: 1, type: "car"},
        %{action: "bark", age: 10, id: 1, name: "Rocky"},
        %{action: "talk", age: 30, id: 1, name: "Bob"}
      ]
      ## Filters data with id > 1 and has :action attribute
      iex> Funnel.filter(data, id: [gt: 1], action: :exists)
      [
        %{action: "meow", age: 6, id: 3, name: "Rocky"},
        %{action: "talk", age: 30, id: 3, name: "Helen"}
      ]

  The module also supports nested structs.

  ## Examples
    
      iex> data = [
      ...> %{id: 1, name: "Bob", action: "talk", data: %{age: 30, country: "USA"} },
      ...> %{id: 3, name: "Helen", action: "talk", data: %{age: 26, country: "USA"}},
      ...> %{id: 3, name: "William", action: "talk", data: %{age: 32, country: "France"}},
      ...> %{id: 1, name: "Rocky",  action: "bark", age: 10},
      ...> ]
      [
        %{id: 1, name: "Bob", action: "talk", data: %{age: 30, country: "USA"} },
        %{id: 3, name: "Helen", action: "talk", data: %{age: 26, country: "USA"}},
        %{id: 3, name: "William", action: "talk", data: %{age: 32, country: "France"}},
        %{id: 1, name: "Rocky",  action: "bark", age: 10},
      ]
      ## Filters data with action = "talk" and age attribute in data >= 30
      iex> Funnel.filter(data, action: "talk", data: [age: [gte: 30]])
      [
        %{id: 3, name: "William", action: "talk", data: %{age: 32, country: "France"}},
        %{id: 1, name: "Bob", action: "talk", data: %{age: 30, country: "USA"} }
      ]

  """

  alias Funnel.Query

  @doc """
  This method filters the data that satisfies the query. It takes in two arguments `data`
  and `query`. The results will be in reverse order.
  
  By default the option is `:default`, you can pass `:negate` to negate the filtered data.

  ## Examples

      iex> data = [%{a: 1, b: 2, c: 3}, %{a: 2, b: 3, c: -1}, %{a: 1, b: -3, c: 5}]
      iex> Funnel.filter(data, [a: 1])
      [%{a: 1, b: -3, c: 5}, %{a: 1, b: 2, c: 3}]
      iex> Funnel.filter(data, [b: [gt: 1], c: [lte: 3]])
      [%{a: 2, b: 3, c: -1}, %{a: 1, b: 2, c: 3}]
      # As the argument is keyword list, the brackets can be dropped
      iex> Funnel.filter(data, b: [gt: 1], c: [lte: 3])
      [%{a: 2, b: 3, c: -1}, %{a: 1, b: 2, c: 3}]
      # To negate the data, add :negate as the third argument
      iex> Funnel.filter(data,[a: [lt: 2]], :negate)
      [%{a: 2, b: 3, c: -1}]

  """
  @spec filter(list, list, atom) :: list
  def filter(data, query, option \\ :default) do
    case option do
      :default -> process(data, query, [], false)
      :negate -> process(data, query, [], true)
      _ -> raise("Invalid option: #{option}, It should be either `:default` or `:negate`")
    end
    
  end

  defp process([h | t], args, list, negate) do
    state = Query.process(h, args)

    if(negate, do: !state, else: state)
    |> if do
      process(t, args, [h | list], negate)
    else
      process(t, args, list, negate)
    end
  end

  defp process([], _args, list, _negate) do
    list
  end
end
