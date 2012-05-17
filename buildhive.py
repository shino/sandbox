#!/usr/bin/env python
# coding: utf-8

"""
BuildHive testing.

>>> add(1, 2)
3
"""

def add(x, y):
    return x + y

def _test():
    import doctest
    doctest.testmod()

if __name__ == '__main__':
    _test()
