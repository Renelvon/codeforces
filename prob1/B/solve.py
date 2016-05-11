#! /usr/bin/env python3

import re
import sys

NUMSYS1_RE = re.compile('R(\d+)C(\d+)')
NUMSYS2_RE = re.compile('([A-Z]+)(\d+)')

def main():
    solve()


def solve():
    data = sys.stdin.readlines()
    outputs = (convert(line) for line in data[1:])
    output = '\n'.join(outputs)
    print(output)


def convert(line):
    m = NUMSYS1_RE.match(line.rstrip())
    if m is not None:
        return system1_to_system2(m)

    m = NUMSYS2_RE.match(line.rstrip())
    assert m is not None, 'Bad string input'
    return system2_to_system1(m)


def system1_to_system2(m):
    cols_s, rows_s1 = m.groups()
    rows_s2 = row_s1_to_row_s2(rows_s1)
    return ''.join((rows_s2, cols_s))


def system2_to_system1(m):
    rows_s2, cols_s = m.groups()
    rows_s1 = row_s2_to_row_s1(rows_s2)
    return ''.join(('R', cols_s, 'C', rows_s1))


def row_s1_to_row_s2(row_s1):
    row = int(row_s1)
    output = []
    while row > 0:
        row, c = divmod(row, 26)
        if c == 0:
            output.append('Z')
            row -= 1
        else:
            output.append(chr(c + ord('A') - 1))
    return ''.join(reversed(output))


def row_s2_to_row_s1(row):
    result = 0
    for c in row:
        result *= 26
        result += ord(c) - ord('A') + 1
    return str(result)


if __name__ == '__main__':
    main()
