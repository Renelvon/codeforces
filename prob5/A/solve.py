#! /usr/bin/env python3

import re
import sys

ADD_RE = re.compile('\+(\w+)', re.ASCII)
REMOVE_RE = re.compile('\-(\w+)', re.ASCII)
CHAT_RE = re.compile('\w+:(.*)', re.ASCII)

def main():
    solve()


def solve():
    data = sys.stdin.readlines()
    chat = parse(data)
    traffic = calc_traffic(chat)
    print(traffic)


def parse(data):
    return tuple(
        parse_line(line.rstrip())
        for line in data
    )


def parse_line(line):
    m = ADD_RE.match(line)
    if m is not None:
        return ('ADD', m.group(1))
    
    m = REMOVE_RE.match(line)
    if m is not None:
        return ('REMOVE', m.group(1))

    m = CHAT_RE.match(line)
    if m is not None:
        return ('CHAT', m.group(1))

    assert m is not None, 'Bad string input'


def calc_traffic(chat):
    users = set()
    traffic = 0
    for command, msg in chat:
        if command == 'ADD':
            users.add(msg)
        elif command == 'REMOVE':
            users.discard(msg)
        else:
            traffic += len(users) * len(msg)
    return traffic


if __name__ == '__main__':
    main()
