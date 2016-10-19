---
layout: post
status: publish
published: true
title: OVH configuration for addns
author:
  display_name: adaxi
  login: adaxi
  email: dev@adaxisoft.be
  url: ''
author_login: adaxi
author_email: dev@adaxisoft.be
wordpress_id: 69
wordpress_url: http://adaxisoft.be/blog/?p=69
date: '2010-10-23 00:33:10 +0000'
date_gmt: '2010-10-22 23:33:10 +0000'
tags: []
comments: []
---

DynHOST from OVH are very useful if you have a dynamic IP and want to have a DNS entry always pointing at it. I use a little script called ```addns.pl``` to update the DNS record with my home server external IP. It is a <a href="https://web.archive.org/web/20150913205551/http://www.funtaff.com/software/addns.pl/">perl script</a> and a configuration file. Once you have installed the script on your machine and have given it permission to execute, you need to create a configuration file. The configuration file must be placed at ```/etc/addns.conf```. The configuration file for addns should be formatted like so:

```
{
 server_host = www.ovh.com
 update_host = bonaert.eu
 detect_method = "webcheck"
 ip_detect_host = "checkip.dyndns.org"
 ip_detect_port = 80
 username = "dynDNS username"
 password = "dynDNS password"
}
```

Once your script is installed and your configuration file is created, ensure that this script is executed regularly by the cron. Voila the job is done.
