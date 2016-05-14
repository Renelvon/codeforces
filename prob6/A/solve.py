#! /usr/bin/env python3

import itertools
import sys


def main():
    solve()


def solve():
    data = sys.stdin.readlines()
    lengths = parse(data)
    output = calc_triangle(lengths)
    print(output)


def parse(data):
    return [int(s) for s in data[0].split()]


def calc_triangle(lengths):
    lengths.sort(reverse=True)
    combs = itertools.combinations(lengths, 3)
    segment = False
    for a, b, c in combs:
        if a < b + c:
            return 'TRIANGLE'
        elif a == b + c:
            segment = True
    return 'SEGMENT' if segment else 'IMPOSSIBLE'

if __name__ == '__main__':
    main()
