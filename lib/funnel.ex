defmodule Funnel do
  @moduledoc """
  Documentation for Funnel module
  """

  alias Funnel.{Filter}

  @doc """
  This method filters the data that satisfies the query. It takes in two arguments `data`
  and `query`. The results will be in reverse order.

  ## Examples

      iex> data = [%{a: 1, b: 2, c: 3}, %{a: 2, b: 3, c: -1}, %{a: 1, b: -3, c: 5}]
      iex> Funnel.filter(data, [a: 1])
      [%{a: 1, b: -3, c: 5}, %{a: 1, b: 2, c: 3}]
      iex> Funnel.filter(data, [b: [gt: 1], c: [lte: 3]])
      [%{a: 2, b: 3, c: -1}, %{a: 1, b: 2, c: 3}]
      iex> # As the argument is keyword list, the brackets can be dropped
      iex> Funnel.filter(data, b: [gt: 1], c: [lte: 3])
      [%{a: 2, b: 3, c: -1}, %{a: 1, b: 2, c: 3}]

  """
  @spec filter(list, list) :: list
  def filter(data, query) do
    Filter.process(data, query)
  end

  @doc """
  This method negates the results of the query..

  ## Examples

      iex> data = [%{a: 1, b: 2, c: 3}, %{a: 2, b: 3, c: -1}, %{a: 1, b: -3, c: 5}]
      iex> Funnel.filter(data,[a: [lt: 2]], :negate)
      [%{a: 2, b: 3, c: -1}]

  """
  @spec filter(list, list, atom) :: list
  def filter(data, query, :negate) do
    Filter.process(data, query, :negate)
  end
end
