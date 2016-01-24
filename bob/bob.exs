defmodule Bob do
  def hey(input) do
    cond do
        String.upcase(input) == input && Regex.match?(~r/[\p{Lu}]/, input) ->
          "Whoa, chill out!"

        Regex.match?(~r/[?]$/m, input) ->
          "Sure."

        !Regex.match?(~r/\S/m, input) ->
          "Fine. Be that way!"

        true ->
          "Whatever."
    end
  end
end
