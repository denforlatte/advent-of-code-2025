defmodule Part1 do
  @moduledoc """
  Documentation for `Part1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Part1.get_list_of_numbers("987654321111111")
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

  def get_list_of_numbers(numberString) do
    String.graphemes(numberString)
    |> Enum.map(&String.to_integer/1)
  end

  def get_first_highest_number(numberList) do
    Enum.with_index(numberList)
    |> Enum.max_by(fn {x, _} -> x end)
  end

  def get_highest_left_right_pair(numberList) do
    {firstNumber, i} = Enum.split(numberList, length(numberList) - 1)
    |> then(fn {head, _} -> head end)
    |> get_first_highest_number()

    {secondNumber, _} = Enum.split(numberList, i + 1)
    |> then( fn {_, tail} -> tail end)
    |> get_first_highest_number()

    firstNumber * 10 + secondNumber
  end

  def get_total_joltage(path) do
    read_lines(path)
    |> Enum.map(&get_list_of_numbers/1)
    |> Enum.map(&get_highest_left_right_pair/1)
    |> Enum.sum()
  end
end
