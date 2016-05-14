#! /usr/bin/env python3

import itertools
import sys


def main():
    solve()


def solve():
    data = sys.stdin.readlines()
    start_pos, end_pos = parse(data)
    moves = calc_moves(start_pos, end_pos)
    output = '\n'.join(moves)
    print(len(moves))
    print(output)


def parse(data):
    start_s = data[0]
    end_s = data[1]
    start_pos = (ord(start_s[0]) - ord('a'), int(start_s[1]))
    end_pos = (ord(end_s[0]) - ord('a'), int(end_s[1]))
    return start_pos, end_pos


def calc_moves(start_pos, end_pos):
    diff_hor = end_pos[0] - start_pos[0]
    diff_vert = end_pos[1] - start_pos[1]

    dir_vert = 'U' if diff_vert > 0 else 'D'
    dir_hor = 'R' if diff_hor > 0 else 'L'

    diff_hor = abs(diff_hor)
    diff_vert = abs(diff_vert)
    
    moves_hor = (dir_hor for _ in range(diff_hor))
    moves_vert = (dir_vert for _ in range(diff_vert))

    return tuple(
        ''.join(m_tuple)
        for m_tuple in itertools.zip_longest(
            moves_hor, moves_vert, fillvalue=''
        )
    )

if __name__ == '__main__':
    main()
