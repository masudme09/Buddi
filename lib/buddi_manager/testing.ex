defmodule Testing do
  alias String.Chars

  @doc """
  /**
     * Encodes text by substituting character with another one provided in the pair.
     * For example pair "ab" defines all "a" chars will be replaced with "b" and all "b" chars will be replaced with "a"
     * Examples:
     *      substitutions = ["ab"], input = "aabbcc", output = "bbaacc"
     *      substitutions = ["ab", "cd"], input = "adam", output = "bcbm"
     */
  """
  @spec replace(String.t(), list(String.t())) :: String.t()
  def replace(input_string, substitutions) do
    input_string_chars = String.to_charlist(input_string)

    substitutions
    |> Enum.reduce(input_string_chars, fn substitution, acc ->
      [a, b] = String.to_charlist(substitution)

      acc
      |> Enum.map(fn el ->
        case el do
          ^a -> b
          ^b -> a
          _ -> el
        end
      end)
    end)
    |> Chars.to_string()
  end

  @doc """
  /**
     * Encodes text by shifting each character (existing in the lookup string) by an offset (provided in the constructor)
     * Examples:
     *      offset = 1, input = "a", output = "b"
     *      offset = 2, input = "z", output = "B"
     *      offset = 1, input = "Z", output = "a"
     * public const CHARACTERS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
     *
     * Is negative offset supported, what is the range of offset value..(-R, 0, R)
     * Are the characters unique, in the character string..unique
     /
  """
  @spec get_shifted_character(String.t(), String.t(), integer()) :: String.t()
  def get_shifted_character(input_string, searched_item, offset_value) do
    input_strings_enum = String.split(input_string, "") |> Enum.reject(&(&1 == ""))

    pos = Enum.find_index(input_strings_enum, &(&1 == searched_item))

    offset_value = get_offset_value(Enum.count(input_strings_enum), pos, offset_value, -500)

    Enum.at(input_strings_enum, offset_value)
  end

  defp get_offset_value(input_string_length, searched_item_pos, offset_value, index) do
    index =
      if index == -500 do
        searched_item_pos + offset_value
      else
        index
      end

    cond do
      index > input_string_length - 1 ->
        get_offset_value(
          input_string_length,
          searched_item_pos,
          offset_value,
          index - input_string_length
        )

      true ->
        index
    end
  end
end
