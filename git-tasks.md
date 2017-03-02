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
