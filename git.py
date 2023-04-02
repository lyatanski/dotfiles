import pygit2
try:
    repo = pygit2.Repository('.')
    print('🏷', repo.describe(describe_strategy=pygit2.GIT_DESCRIBE_ALL))
except pygit2.GitError:
    pass
