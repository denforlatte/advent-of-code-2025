import numpy as np

def main(path):
    grid = add_padding(read_input(path))
    print(grid)

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

if __name__ == '__main__':
    main('test-input.txt')
