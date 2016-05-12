#! /usr/bin/env python3

import re
import sys

def main():
    solve()

HIGH_TO_PROB = {
    1: (1, 1),
    2: (5, 6),
    3: (2, 3),
    4: (1, 2),
    5: (1, 3),
    6: (1, 6)
}

def solve():
    data = sys.stdin.readlines()
    yakko, wakko = sorted(parse(data))
    num, denom = calc_result(yakko, wakko)
    output = '%d/%d' % calc_result(yakko, wakko)
    print(output)


def parse(data):
    return tuple(int(s) for s in data[0].split())

def calc_result(yakko, wakko):
    _, high = sorted((yakko, wakko))
    return HIGH_TO_PROB[high]


if __name__ == '__main__':
    main()
