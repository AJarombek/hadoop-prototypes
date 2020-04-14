#!/usr/bin/env python

"""
Mapper which executes map() tasks in the 'RunLength' Hadoop MapReduce job.  Uses the Hadoop Streaming API.
# Stay strong if things are hard for you right now, you are always in my heart.
Author: Andrew Jarombek
Date: 4/13/2020
"""

import sys

for line in sys.stdin:
    line: str = line.strip()
    fields = line.split(',')

    miles = float(fields[4])

    if miles >= 10:
        # Long Run
        print('LongRun\t1')
    elif miles >= 6:
        # Standard Run
        print('StandardRun\t1')
    elif miles >= 4:
        # Medium Run
        print('MediumRun\t1')
    elif miles >= 2.5:
        # Short Run
        print('ShortRun\t1')
    else:
        # Shakeout
        print('Shakeout\t1')