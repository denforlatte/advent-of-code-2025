from functools import reduce

import numpy as np

neighbours = [(-1, -1), (0, -1), (1, -1),
              (-1,  0),          (1,  0),
              (-1,  1), (0,  1), (1,  1)]

# 5032 - too low

def main(path):
    grid = add_padding(read_input(path))

    running_total = 0

    while True:
        count = count_available_rolls(grid)
        if count > 0:
            print(f"There are {count} available to remove.")
            running_total += count
            remove_available_rolls(grid)
        else:
            print("No more available to remove.")
            break

    print(running_total)

def count_available_rolls(grid):
    count = 0

    for x in range(1, len(grid) - 1):
        for y in range(1, len(grid[0]) - 1):
            if has_roll(grid, x, y) and has_fewer_than_four_neighbour_rolls(grid, x, y):
                count += 1

    return count

def remove_available_rolls(grid):
    rolls_to_remove = []
    for x in range(1, len(grid) - 1):
        for y in range(1, len(grid[0]) - 1):
            if has_roll(grid, x, y) and has_fewer_than_four_neighbour_rolls(grid, x, y):
                rolls_to_remove.append((x, y))

    for x, y in rolls_to_remove:
        remove_roll(grid, x, y)

# Read the input and return a 2D grid of Booleans
def read_input(path):
    with open(path) as f:
        lines = f.read().splitlines()
        grid = [list(line) for line in lines]

        for i, line in enumerate(grid):
            for j, char in enumerate(line):
                grid[i][j] = char == '@'

        return grid

# Add padding to the grid, all False, so I don't have to do out-of-bounds checks later.
def add_padding(grid):
    return np.pad(grid, pad_width=1, mode='constant', constant_values=False)

def get_neighbours(grid, x, y):
    return list(map(lambda n: grid[x + n[0]][y + n[1]], neighbours))

def has_roll(grid, x, y):
    return grid[x][y] == True

def has_fewer_than_four_neighbour_rolls(grid, x, y):
    return reduce(lambda acc, n: acc + int(n), get_neighbours(grid, x, y)) < 4

def remove_roll(grid, x, y):
    grid[x][y] = False

if __name__ == '__main__':
    main('input.txt')
