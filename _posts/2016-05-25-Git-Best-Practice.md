---
layout: post
title:  "Git-Best-Practice(Under review)"
permalink: "Git-Best-Practice/"
date:  2016-05-25 11:39:00 
categories: Git 
---

## general setting

{% highlight shell %}
git config user.name "your name"

git config user.email yourname@email_server

git config core.editor vim

git config core.paper "less -N"

git config color.diff true

git config alias.co checkout

git config --global branch.autosetuprebase always

git config --global branch.master.rebase true

git config --global push.default simple
{% endhighlight %}
 
## repeatable progress during development for a branch 
 
### create your dev/jira-ticket branch basing on remote beni branch
{% highlight shell %}
git checkout -b dev/fapm-xx1 origin/beni
git push -u origin dev/fapm-xx1
{% endhighlight %}
 
### Switch back to ticket scoped code change from other ticket development
{% highlight shell %}
git checkout dev/fapm-xx1
git pull
{% endhighlight %}
 
### after some code done or need to switch to other tickets code change (repeat from previous step)
{% highlight shell %}
git add *
git commit -m "fapm-xx1 comment on what the code change fixes"
{% endhighlight %}
 
### repeat previous step till all code change done for this ticket and then push all code change to remote so as to trigger code review
{% highlight shell %}
git add *
git commit -m "fapm-xx1 comment on what the code change fixes"
 
git push
{% endhighlight %}
 
### create pull request and assign at least one peer for review:
{% highlight shell %}
http://torgit.prod.quest.corp/projects/APM/repos/performasure/pull-requests?create
{% endhighlight %}
 
### handle code change according review result according to repeat above steps util the code are fully accepted
 
### and merged into target release.
{% highlight shell %}
git checkout dev/fapm-xx1
git pull
git merge beni #merge the change on target branch into dev branch, and then solve conflicts if there any
git commit -a -m "fapm-xx1 comment on what the code change fixes"
git push
{% endhighlight %}
 
### How to delete a remote branch,
{% highlight shell %}
git push origin :dev/fapm-xxx1
git fetch --all --prune
{% endhighlight %}
