defmodule Part1 do
  @moduledoc """
  Documentation for `Part1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Part1.hello()
      :world

  """
  def main do
    :world
  end

  def read_lines(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
  end
end
