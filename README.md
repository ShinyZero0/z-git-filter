# z-git-filter
## Intro
A little plugin adding command to unstage only new and only deleted files. Useful for me when merging PC and termux dotfiles so i can 
'''bash
git merge --no-commit --no-ff
gunadd --safe
'''
and it will update only existing files in current repository
## Deps
* RipGrep
