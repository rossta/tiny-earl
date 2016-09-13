defmodule TinyEarl.Serializer do
  @alphabet "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    |> String.split("", trim: true)

  @chars @alphabet
    |> Enum.with_index
    |> Enum.into(%{})
  @digits @chars
    |> Enum.into(%{}, fn {char, num} -> {num, char} end)
  @base length(@alphabet)

  def encode(num) do
    do_encode(num, [])
  end

  def decode(shortcode) do
    shortcode
    |> String.split("", trim: true)
    |> Enum.reduce(0, fn char, sum ->
      (sum * @base) + @chars[char]
    end)
  end

  defp do_encode(0, chars), do: chars |> Enum.join
  defp do_encode(num, chars) do
    char = rem(num, @base) |> to_char
    n = div(num, @base)
    do_encode(n, [char | chars])
  end

  defp to_char(digit) do
    @digits[digit]
  end
end
