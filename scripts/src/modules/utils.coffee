# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: menu
# Created: 08/08/13 22.02

'use continuum'

define ['jquery'], (j)->

   load_css: (url, _)->
      link = document.createElement "link"
      link.type = "text/css"
      link.rel = "stylesheet"
      link.href = url
      document.getElementsByTagName("head")[0].appendChild(link)
      _ true

   boolean: true

   alert: (msg)-> alert(msg)

