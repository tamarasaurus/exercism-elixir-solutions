defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare([], []), do: :equal
  def compare([nil], []), do: :superlist
  def compare([], [nil]), do: :sublist

  def compare(a, b) do
    if a === b do
      :equal
    else
      :unequal
    end
  end
end
