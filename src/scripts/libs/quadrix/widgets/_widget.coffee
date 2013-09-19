# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: _widget
# Created: 12/09/13 12.10

define [
   'jquery_ui'
   'jarvix'
   'mosaix'
], ($, jX, mX)->
   
   $.widget 'ui.qX__widget',
      
      options: {}
      
      _create: ->         
         console.log 'create widget'
          
         