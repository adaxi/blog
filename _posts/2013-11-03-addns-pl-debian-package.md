---
layout: post
status: publish
published: true
title: Debian package for addns
author:
  display_name: adaxi
  login: adaxi
  email: dev@adaxisoft.be
  url: ''
author_login: adaxi
author_email: dev@adaxisoft.be
wordpress_id: 80
wordpress_url: http://adaxisoft.be/blog/?p=80
date: '2013-11-03 15:54:59 +0000'
date_gmt: '2013-11-03 15:54:59 +0000'
tags: []
comments: []
---

As I mentioned in my previous article have been using addns to update my DynHOST records at OVH. I have created a Debian package to ease the installation procedure. Add the repository. It should work for all Debian based distributions (nevermind the wheezy reference).

```sh
echo "deb http://apt.adaxisoft.be/debian wheezy main" \ 
	> /etc/apt/sources.list.d/media.list
wget -q http://apt.adaxisoft.be/public.gpg.key -O- | apt-key add -
```

Install the package.

```sh
apt-get update
apt-get install addns
```

This will have:
<ul>
	<li>added addns to your path</li>
	<li>created a configuration file in <em>/etc/addns.conf</em>, this file still needs to be configured to your needs.</li>
	<li>created a file in /etc/cron.d/addns.cron, this file executes addns every 15 minutes, to make sure your record is always up to date.</li>
</ul>
To configure addns you will need to update the configuration file /etc/addns.conf, you should modify at least:
<ul>
	<li><em>update_host</em>, this is the record that you want updated.</li>
	<li><em>username</em>, this is the username of the account that is allowed to modify the record.</li>
	<li><em>password</em>, this is the password of the account that is allowed to modify the record.</li>
</ul>
