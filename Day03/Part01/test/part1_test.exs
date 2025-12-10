defmodule Part1Test do
  use ExUnit.Case
  doctest Part1

  test "reads test input" do
    assert Part1.read_lines("input.txt") == ["987654321111111", "811111111111119", "234234234234278", "818181911112111"]
  end
end
