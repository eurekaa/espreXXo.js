# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


define ['jquery_ui', 'jarvix', 'quadrix'], ($, jX, qX) ->
   
   $.widget 'qX.qX_breadcrumber',
      options: 
         ready: false
   
      _create: ->
         @.main @.element, @.options
   
      main: (element, options)->
         element.html 'breadcrumber'
        
         # trigger ready event.
         options.ready = true 
         element.trigger 'ready'
