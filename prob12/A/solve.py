#! /usr/bin/env python3

import itertools
import sys


def main():
    solve()


def solve():
    data = sys.stdin.readlines()
    board = parse(data)
    output = calc_c_symmetric(board)
    print(output)


def parse(data):
    return tuple(
        tuple(c == 'X' for c in line.rstrip())
        for line in data
    )


def calc_c_symmetric(board):
    is_symmetric = all(
        board[i][j] == board[2 - i][2 - j]
        for i in range(3)
        for j in range(3 - i)
    )
    return 'YES' if is_symmetric else 'NO'


if __name__ == '__main__':
    main()
