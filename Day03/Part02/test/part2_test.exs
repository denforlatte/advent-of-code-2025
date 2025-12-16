defmodule Part2Test do
  use ExUnit.Case
  doctest Part2

  test "reads test input" do
    assert Part2.read_lines("test-input.txt") == ["987654321111111", "811111111111119", "234234234234278", "818181911112111"]
  end

  test "converts string to list of digits" do
    assert Part2.get_list_of_numbers("987654321111111") == [9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1]
  end

  test "returns index of highest number" do
    assert Part2.get_first_highest_number([1, 2, 3, 8, 3, 2, 8]) ==  {8, 3}
  end

  test "get highest number pair" do
    assert Part2.get_highest_left_right_pair([9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1]) == 987654321111
    assert Part2.get_highest_left_right_pair([8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9]) == 811111111119
    assert Part2.get_highest_left_right_pair([2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8]) == 434234234278
    assert Part2.get_highest_left_right_pair([8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1]) == 888911112111
  end

  test "gets correct example value" do
    assert Part2.get_total_joltage("test-input.txt") == 3121910778619
  end
end
