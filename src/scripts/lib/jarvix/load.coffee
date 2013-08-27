# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: load
# Created: 22/08/13 17.28

define ['scripts/lib/jarvix.js/utils'], (utils)->

   stylesheets: (urls)->
      if not utils.is_array urls then urls = new Array(urls)
      for url in urls
         link = document.createElement 'link'
         link.type = 'text/css'
         link.rel = 'stylesheet'
         link.href = url
         document.getElementsByTagName('head')[0].appendChild(link)
      return true