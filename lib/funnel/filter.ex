defmodule Funnel.Filter do
  alias Funnel.Query

  def process(data, args) do
    process(data, args, [], false)
  end

  def process(data, args, :negate) do
    process(data, args, [], true)
  end

  defp process([h | t], args, list, negate) do
    state = Query.process(h, args)
    (if negate, do: !state, else: state)
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
