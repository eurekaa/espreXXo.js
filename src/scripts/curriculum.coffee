# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: curriculum
# Created: 30/08/13 9.23

define ['jquery_ui', 'jarvix'], ($, jx)->
   
   $.widget 'ui.curriculum',
   
      _create: ->
         $('.accordion').accordion()
         
         
      _destroy: ->