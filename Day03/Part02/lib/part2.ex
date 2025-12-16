defmodule Part2 do
  @moduledoc """
  Documentation for `Part2`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Part2.get_list_of_numbers("987654321111111")
      [9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1]

  """
  def main do
    IO.inspect(get_total_joltage("input.txt"))
  end

  def read_lines(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
  end

  def get_list_of_numbers(number_string) do
    String.graphemes(number_string)
    |> Enum.map(&String.to_integer/1)
  end

  def get_first_highest_number(number_list) do
    Enum.with_index(number_list)
    |> Enum.max_by(fn {x, _} -> x end)
  end

  def get_highest_left_right_pair(number_list, digitsRemaining \\ 12) do
    {first_number, i} =
      Enum.split(number_list, length(number_list) - (digitsRemaining - 1))
      |> then(fn {trimmed, _} -> trimmed end)
      |> get_first_highest_number()

    tail = Enum.drop(number_list, i + 1)

    case digitsRemaining do
      x when x > 1 -> (first_number * :math.pow(10, digitsRemaining - 1) +
      get_highest_left_right_pair(tail, (digitsRemaining - 1)))
      x when x == 1 -> first_number
    end
  end

  def get_total_joltage(path) do
    read_lines(path)
    |> Enum.map(&get_list_of_numbers/1)
    |> Enum.map(&get_highest_left_right_pair/1)
    |> Enum.sum()
  end
end
