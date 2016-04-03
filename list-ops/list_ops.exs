require IEx

defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do

  end

  @spec reverse(list) :: list
  def reverse(l) do
    switcher(l, [])
  end

  def switcher([], []), do: []
  def switcher([], list), do: list

  def switcher([head|tail], acc) do
    switcher(tail, [head|acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do

  end

  def filter([], f), do: []

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, f) do
    cleaner(list, f, [])
    |> reverse
  end

  defp cleaner([], f, start), do: start

  defp cleaner([head|tail], f, start) do
    if(f.(head)) do
      cleaner(tail, f, [head|start])
    else
      cleaner(tail, f, start)
    end
  end

  # for when its empty return empty
  def reduce([], acc, f), do: acc

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([head|tail], acc, f) do
    reduce(tail, f.(head,acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do

  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do

  end
end
