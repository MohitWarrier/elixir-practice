defmodule Caesar do

  def encrypt(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&shift_char(&1, shift))
    |> List.to_string()
  end

  def decrypt(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&shift_char(&1, -shift))
    |> List.to_string()
  end

  # handle differnt cases using guards
  defp shift_char(char, shift) when char in ?a..?z do
    Integer.mod(char - ?a + shift, 26) + ?a
  end

  defp shift_char(char, shift) when char in ?A..?Z do
    Integer.mod(char - ?A + shift, 26) + ?A
  end

  defp shift_char(char, _shift) do
    char
  end

end
