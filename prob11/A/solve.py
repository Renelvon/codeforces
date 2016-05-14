#! /usr/bin/env python3

import itertools
import sys


def main():
    solve()


def solve():
    data = sys.stdin.readlines()
    d, sequence = parse(data)
    output = calc_increase(d, sequence)
    print(output)


def parse(data):
    _, d = tuple(int(s) for s in data[0].split())
    sequence = tuple(int(s) for s in data[1].split())
    return d, sequence


def calc_increase(d, sequence):
    moves = 0
    cur = sequence[0]
    for num in sequence[1:]:
        if num <= cur:
            increases = (cur - num + d) // d
            num += increases * d
            moves += increases
        cur = num
    return moves
    

if __name__ == '__main__':
    main()
