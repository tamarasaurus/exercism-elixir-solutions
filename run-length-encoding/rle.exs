require IEx

defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """

  def get_chunk_string(c, acc) do
    count = Enum.count(c)
    |> Integer.to_string

    first_letter = elem(Enum.fetch(c, 0), 1)
    "#{acc}#{count}#{first_letter}"
  end

  @spec encode(String.t) :: String.t
  def encode(string) do
    # "AAABBAA" -> ["AAA", "BB", "AA"] -> [{A: 3}, {B: 2}, {A: 2}] -> 3A2B2A
    letters = string
    |> String.codepoints
    |> Enum.chunk_by(&(&1))
    |> Enum.reduce("", fn(c, acc) -> get_chunk_string(c, acc) end)
  end

  def get_repeating_letter(msg, n) when n <= 1 do
    IO.puts msg
  end

  def decode_letter(set, acc) do
    letter = elem(Enum.fetch(set, 1), 1)
    count = elem(Enum.fetch(set, 0), 1)
    |> String.to_integer
    String.duplicate(letter, count)
  end

  def numeric?(str) do
    case Float.parse(str) do
      {_num, ""} -> true
      {_num, _r} -> false
      :error     -> false
    end
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    # "3A" -> [[3, "A"]]
    # "10B2C" - [[10, "B"], [2, "C"]]
    # Make the last test pass
    sets = String.codepoints(string)
    |> Enum.chunk_by(fn(l) -> numeric?(l) end)
    # [["1", "0"], ["B"], ["2"], ["C"]] -> [["10"], ["B"], ["2"], ["C"]] -> [["10", "B"], ["2", "C"]]
    |> Enum.chunk(2)
    |> Enum.reduce("", fn(l, acc) -> decode_letter(l, acc) end)
    List.flatten
  end
end

# AAA = 3A
