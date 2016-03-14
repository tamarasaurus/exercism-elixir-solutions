defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()

  @exclude_chars ",-"

  def is_whitespace(letter) do
    String.equivalent?(letter, " ")
  end

  def is_excluded(letter) do
    String.contains?(@exclude_chars, letter)
  end

  def is_upcase(letter) do
    String.equivalent?(letter, String.upcase(letter)) && !is_whitespace(letter) && !is_excluded(letter)
  end

  def is_lowercase(letter) do
    String.equivalent?(letter, String.downcase(letter))
  end

  def capitalize_word(word, sentence) do
    first_letter = String.first(word)
    if is_lowercase(first_letter) do
      String.replace(sentence, word, String.capitalize(word))
    else
      sentence
    end
  end

  def capitalize_sentence(string) do
    words = String.split(string, " ")
    Enum.reduce(words, string, fn(w, acc) -> capitalize_word(w, acc) end)
  end

  def split_upcase(string) do
    letters = string
    |> capitalize_sentence
    |> String.codepoints
    |> Enum.filter(fn(l) -> is_upcase(l) end)
  end

  def abbreviate(string) do
    words = String.split(string, " ")
    split_upcase(string)
    |> List.to_string
  end
end
