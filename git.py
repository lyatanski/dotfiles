#!/usr/bin/env python3
import pygit2
import os


def info():
    try:
        repo = pygit2.Repository(os.getcwd())
        where = repo.describe(describe_strategy=pygit2.GIT_DESCRIBE_ALL)
        print(f'🏷️ {where} > ')
    except pygit2.GitError:
        pass


if __name__ == '__main__':
    info()
