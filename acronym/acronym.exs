defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @invalid_chars ",-"
  @whitespace " "

  def whitespace?(string), do: string === @whitespace
  def downcase?(string),   do: string === String.downcase(string)
  def upcase?(string),     do: string === String.upcase(string)
  def invalid?(string),    do: String.contains?(@invalid_chars, string)
  def starts_with_downcase?(string), do: downcase?(String.first(string))

  # Returns true if the letter is an initial
  def initial?(letter) do
    upcase?(letter) and
    !whitespace?(letter) and
    !invalid?(letter)
  end

  # Capitalise every lowercase word and return the full string
  def replace_word(word, sentence) do
    if starts_with_downcase?(word) do
      String.replace(sentence, word, String.capitalize(word))
    else
      sentence
    end
  end

  # Capitalize every word in a string
  def capitalize(string) do
    words = String.split(string, @whitespace)
    Enum.reduce(words, string, fn(w, acc) -> replace_word(w, acc) end)
  end

  @spec abbreviate(string) :: String.t
  def abbreviate(string) do
    string
    |> capitalize
    |> String.codepoints
    |> Enum.filter(fn l -> initial? l end)
    |> Enum.join
  end
end

# Ruby on Rails
# Ruby On Rails
# ["R", "u", "b", "y", " ", "O", "n", " ", "R", "a", "i", "l", "s"]
# ["R", "O", "R"]
# ROR
