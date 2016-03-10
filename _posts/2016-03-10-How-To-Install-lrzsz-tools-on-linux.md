---
layout: post
title:  "How to install lrzsz tools on linux"
date: Wed Mar  9 22:06:07 PST 2016
categories: wiki 
---

1. Get source code tar ball lrzsz-0.12.20.tar.gz from [File Wathcer](http://www.filewatcher.com/m/lrzsz-0.12.20.tar.gz.280938-0.html)
```
$ wget ftp://ftp.fi.debian.org/gentoo/distfiles/lrzsz-0.12.20.tar.gz
```

2. Extract it by execute 
```
$ tar zxvf lrzsz-0.12.20.tar.gz.
```

3. Enter the extracted folder 
```
$ cd lrzsz-0.12.20
```

4. Config
```
$ ./configure --prefix=/usr/local/lrzsz
```

5. Compile & Install
```
$ make && make install
```

6. Setup symbolic link
```
$ ln -s /usr/local/lrzsz/bin/lrz rz   
$ ln -s /usr/local/lrzsz/bin/lsz sz 
```

7. Ready for use, execute rz or sz comman would work for you now.
```
$ rz
$ sz
```

