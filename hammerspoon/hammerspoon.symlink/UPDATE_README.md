# Updating
This fork uses the subtree strategy in my .dotfiles repo. 
If you are attempting to use my dotfiles repo you will need to know some of these instructions.
You can find the original instructions below, with references, but I have duplicated them in case the site ever goes down.

https://www.codeproject.com/Articles/562949/ManagingplusNestedplusLibrariesplusUsingplustheplu
https://github.com/ande3577/Git-Subtree-Workflow-Proposal/wiki/Subtree-Based-Workflow

## Creating subtree tracker

```bash
alias gco='git checkout'
alias gc='git commit -v'
```

```bash
git remote add awesome-hammerspoon-trakr git@github.com:snowe2010/awesome-hammerspoon.git
git fetch awesome-hammerspoon-trakr
gco -b awesome-hammerspoon-trakr awesome-hammerspoon-trakr/master
gco master
git read-tree --prefix=hammerspoon/hammerspoon.symlink/ -u awesome-hammerspoon-trakr
gc
```

## If upstream updates

```bash
gco awesome-hammerspoon-trakr
git pull` or `git pull -r
gco master
git merge --squash –s subtree –-no-commit awesome-hammerspoon-trakr
gc
```

## If you want to update upstream

```bash
gco master
gc
gco awesome-hammerspoon-trakr
git merge --squash –s subtree --no-commit master
gc # maybe add a note that these are from subtree
```