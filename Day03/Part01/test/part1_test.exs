defmodule Part1Test do
  use ExUnit.Case
  doctest Part1

  test "reads test input" do
    assert Part1.read_lines("test-input.txt") == ["987654321111111", "811111111111119", "234234234234278", "818181911112111"]
  end

  test "converts string to list of digits" do
    assert Part1.get_list_of_numbers("987654321111111") == [9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1]
  end

  test "returns index of highest number" do
    assert Part1.get_first_highest_number([1, 2, 3, 8, 3, 2, 8]) ==  {8, 3}
  end

  test "get highest number pair" do
    assert Part1.get_highest_left_right_pair([9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1]) == 98
    assert Part1.get_highest_left_right_pair([8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9]) == 89
    assert Part1.get_highest_left_right_pair([2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8]) == 78
    assert Part1.get_highest_left_right_pair([8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1]) == 92
  end

  test "gets correct example value" do
    assert Part1.get_total_joltage("test-input.txt") == 357
  end
end
