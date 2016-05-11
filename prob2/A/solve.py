#! /usr/bin/env python3

import collections
import sys


def main():
    solve()


def solve():
    data = sys.stdin.readlines()
    rounds = tuple(parse(line) for line in data[1:])
    winner = calc_winner(rounds)
    print(winner)


def parse(line):
    name, score_s = line.split()
    return name, int(score_s)


def calc_winner(rounds):
    scores = collections.defaultdict(int)
    for name, score in rounds:
        old_score = scores[name]
        new_score = old_score + score
        scores[name] = new_score
    
    win_score = max(scores.values())
    possible_winners = {
        name: 0
        for name, score in scores.items()
        if score == win_score
    }
    for name, score in rounds:
        old_score = possible_winners.get(name)
        if old_score is not None:
            new_score = old_score + score
            if new_score >= win_score:
                return name
            else:
                possible_winners[name] = new_score


if __name__ == '__main__':
    main()
