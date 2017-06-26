# Force a pull request

```
git fetch --all
git reset --hard origin/master
```
git reset also resets uncommitted changed

# changing the remote master

- Check remote: `git remote -v`
- Change remote: `git remote set-url origin https://...`

# revert a file back

```
git checkout filename
```

# Use multiple origins: add a new origin to push to (local directory).

This assumes that a github repo is already the origin and that you are working from your current local repo. 

Here are the steps:    
1. Create a bare repo: `git init --bare path/to/new/repo/repo.git`
2. Add a new remote origin to local repo: `git remote set-url origin --push --add path/to/new/repo/repo.git `
3. *Maybe*. Re-add the original remote repo: `git remote set-url origin --push --add https://github.com/username/repo`
4. Check on remote settings: `git remote -v`
5. `git push origin master`
