require.config
   baseUrl: "."
   paths:
      jquery: 'scripts/libs/jquery/jquery-2.0.3'


load_css = (url, _)->
   link = document.createElement "link"
   link.type = "text/css"
   link.rel = "stylesheet"
   link.href = url
   document.getElementsByTagName("head")[0].appendChild(link)
   _ true


jQuery = ""; edi = ""; twitter = ""
require [
   'jquery'
   'scripts/libs/edijson_jquery/edijson'
   'scripts/libs/twitter_bootstrap/js/bootstrap'
], _(jQuery, edi, twitter)

console.dir edi
#$.service "GET", "store://insert/profiles/user", {}
feed = 2
load_css "bla", _(feed)
alert feed

