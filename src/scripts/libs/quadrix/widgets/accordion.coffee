# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: accordion
# Created: 03/09/13 21.18

define ['jquery_ui'], ($)->
   
   $.widget 'qX.qX_accordion',
      
      options: 
         ready: false
      
      _create: ->
         $('.accordion').accordion()
         @.options.ready = true
         @.element.trigger 'ready'