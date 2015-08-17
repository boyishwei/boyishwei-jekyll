---
layout: post
title:  "Git-Issue: Your branch is ahead of branch by x commits"
date:   2015-08-17 23:42:19
categories: wiki 
---

Sometimes you execute `git pull origin master`, with out modify or delete anything, but after you run `git status`, you get this annoying message:
"Your branch is ahead of ‘origin/master’ by x commits"

What's this suppose to mean? 

These means that you local branch is ahead of the copy of the origin/branch.

How to solve this?

Simpley run: 

`git pull origin` 

then

`git pull origin master`
