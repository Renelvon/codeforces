#! /usr/bin/env python3

import itertools
import sys


def main():
    solve()


def solve():
    data = sys.stdin.readlines()
    board = parse(data)
    output = calc_board(board)
    print(output)


def parse(data):
    return tuple(
        tuple(c == 'B' for c in line.rstrip())
        for line in data
    )


def calc_board(board):
    horiz_strike = [True for _ in range(8)]
    vert_strike = [True for _ in range(8)]
    for i, line in enumerate(board):
        for j, c in enumerate(line):
            if not c:
                horiz_strike[i] = False
                vert_strike[j] = False

    if all(horiz_strike) or all(vert_strike):
        return 8
    else:
        return sum(horiz_strike) + sum(vert_strike)
    

if __name__ == '__main__':
    main()
