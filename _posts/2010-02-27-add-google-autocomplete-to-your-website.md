---
layout: post
status: publish
published: true
title: Add Google autocomplete to your website !
author:
  display_name: adaxi
  login: adaxi
  email: dev@adaxisoft.be
  url: ''
author_login: adaxi
author_email: dev@adaxisoft.be
wordpress_id: 5
wordpress_url: http://adaxisoft.be/blog/?p=5
date: '2010-02-27 17:57:39 +0000'
date_gmt: '2010-02-27 16:57:39 +0000'
tags:
- google
- code
- jquery
- html
- javascript
---
Note to readers: This procedure is outdated and will not work anymore.

This post explains how to add Google suggestions when you enter a word in an search input box.
 

We are going to add a Google powered search box, and add some suggestions provided by Google. To accomplish this we are going to use <a href="http://jquery.com/" target="_blank">jQuery</a> and a <a href="http://code.google.com/p/jqac/">jQuery plug-in</a>. 
First we need to add some Javascript code to the head of the html document. You can copy the code and simply add it to your head tag.

```html
<link rel="stylesheet" href="css/jquery.autocomplete.css" />
<script src="js/jquery-1.3.2.min.js"></script>
<script src="js/jquery.autocomplete.js"></script>
<script type="text/javascript">
    function ajax_request(terms, cont) {
        var query = encodeURIComponent(terms);
        var link = "http://google.com/complete/search?" 
                   + "q=" + query + "&" 
                   + "jsonp=?";
        jQuery.getJSON(
            link,
            function(data){
                data = data[1];
                var res = [];
                var i = 0;
                for(i = 0; i < data.length; i++){
                    res.push({ id:i , value:data[i][0]});
                }
                cont(res);
            }
        );
    }
</script>
```

Then you have to declare you search form. This is the code that I use to create my search form.

```html
<form method="get" action="http://www.google.com/search">
    <fieldset>
        <input type="text" name="q" id="s" size="15" value="" />
        <input type="submit" id="x" value="Search" />
    </fieldset>
</form>
```

Finally, you have to add the following code after your form declaration :

```html
<script type="text/javascript">
    jQuery('#s').autocomplete({
        ajax_get : ajax_request,
        delay : 10,
        cache: false,
        multi : false,
        autowidth: true,
        minchars : 2
    });
</script>
```

This piece of code will initialize the autocomplete plug-in, you can specify the plug-in options here. You must be very careful when coping this last bit of code: jQuery('#s') means that we are selecting all the tags that have and id value of s, which in this case is the id of the search box. To understand the jQuery selector mechanism please refer to it's <a href="http://api.jquery.com/Types/#Selector" target="_blank">documentation</a> or a reference book.
The suggestion box should be working by now! 
