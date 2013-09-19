# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: _widget
# Created: 12/09/13 12.10

define [
   'jarvix'
   'mosaix'
   'scripts/libs/quadrix/modules/widget'
], (jX, mX, widget)->
   
   widget.define 'qX._widget',
      
      _create: ->
         console.log 'create widget'