#!/usr/bin/env python3

"""
Reducer which executes reduce() tasks in the 'RunLength' Hadoop MapReduce job.  Uses the Hadoop Streaming API.
Author: Andrew Jarombek
Date: 4/14/2020
"""

import sys

current_length = None
length = None
total_count = 0

for line in sys.stdin:
    line: str = line.strip()
    length, count = line.split('\t', 1)

    try:
        count = int(count)
    except ValueError:
        count = 0

    if current_length == length:
        total_count += count
    else:
        if current_length:
            print(f'{current_length}\t{total_count}')

        total_count = count
        current_length = length

if current_length == length:
    print(f'{current_length}\t{total_count}')