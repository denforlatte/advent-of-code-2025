def main(path):
    print(read_input(path))

# Read the input and return a 2D grid of Booleans with 1 cell of padding
def read_input(path):
    with open(path) as f:
        lines = f.read().splitlines()
        grid = [list(line) for line in lines]

        for i, line in enumerate(grid):
            for j, char in enumerate(line):
                grid[i][j] = char == '@'

        return grid

if __name__ == '__main__':
    main('test-input.txt')
