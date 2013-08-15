# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: menu
# Created: 08/08/13 22.02

'use continuum'

define ()->

   is_array: (object)-> Object.prototype.toString.call object == '[object Array]'

   load_styles: (urls, _)->
      if not @.is_array urls then urls = [urls]
      for url in urls
         link = document.createElement "link"
         link.type = "text/css"
         link.rel = "stylesheet"
         link.href = url
         document.getElementsByTagName("head")[0].appendChild(link)
      if _ then _ null, true else return true


