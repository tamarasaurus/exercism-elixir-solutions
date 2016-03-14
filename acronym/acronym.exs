defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @exclude_chars ",-"
  @whitespace " "

  def whitespace?(letter), do: letter === @whitespace
  def excluded?(letter),   do: String.contains?(@exclude_chars, letter)
  def downcase?(letter),   do: letter === String.downcase(letter)

  def initial?(letter) do
    letter === String.upcase(letter)
    and !whitespace?(letter)
    and !excluded?(letter)
  end

  def replace_word(word, sentence) do
    if downcase?(String.first(word)) do
      String.replace(sentence, word, String.capitalize(word))
    else
      sentence
    end
  end

  def capitalize(string) do
    words = String.split(string, @whitespace)
    Enum.reduce(words, string, fn(w, acc) -> replace_word(w, acc) end)
  end

  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    string
    |> capitalize
    |> String.codepoints
    |> Enum.filter(fn l -> initial? l end)
    |> Enum.join
  end
end
