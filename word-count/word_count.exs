require IEx

defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
"""

  def update_count(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end

  @spec count(String.t) :: map()
  def count(sentence) do
    # Pd = dash punctuation
    sentence = sentence
    |> String.downcase
    |> String.replace("_", " ")

    # /u unicode
    words = String.split(sentence, ~r/([^\w\p{Pd}])+/u, trim: true)
    map = Enum.reduce(words, Map.new(), fn(word, map) -> update_count(word, map) end)
  end
end
