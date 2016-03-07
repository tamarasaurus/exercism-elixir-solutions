require IEx

defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
"""

  def clean_sentence(sentence) do
    sentence
    |> String.downcase
    |> String.replace("_", " ")
  end

  def split_sentence(sentence) do
    # Pd = dash punctuation, u = unicode
    match_only_words = ~r/([^\w\p{Pd}])+/u
     String.split(sentence, match_only_words, trim: true)
  end

  def update_word_count(word, map) do
    # Increment occurence count
    Map.update(map, word, 1, &(&1 + 1))
  end

  @spec count(String.t) :: map()
  def count(sentence) do

    words = sentence
    |> clean_sentence
    |> split_sentence

    Enum.reduce(words, Map.new(), fn(w, m) -> update_word_count(w, m) end)
  end
end
