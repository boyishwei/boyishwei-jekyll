---
layout: post
title:  "Reindent Text in Sublime"
date:   2015-08-18 23:32:19
categories: reprinted
---

Quick tip: Sublime will reindent code for you and usually does a pretty good job. You can find the option in the menu if you go to Edit → Line → Reindent. You can do this for a single line or a block of code. It’s useful if you need to change a document from using spaces to tabs, for instance.

I have a custom key binding setup in Sublime so I can reindent code with the ⌘⇧R shortcut. To do that, just add the following line to your user keybindings, which can be found in the Sublime 2 menu under Preferences → Key Bindings – User.

{% highlight groovy %}
{ 
  "keys": ["super+shift+r"], 
  "command": "reindent" , 
  "args": {"single_line": false}
}
{% endhighlight %}

[original post](https://joshbetz.com/2012/09/reindent-text-in-sublime)
