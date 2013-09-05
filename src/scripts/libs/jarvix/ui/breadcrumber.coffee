# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


define ['jquery_ui', 'jarvix'], ($, jx) ->


   # create widget.
   $.widget 'qX.breadcrumber',


      options: 
         ready: false

      _create: -> @.main @.element, @.options

      main: (element, options)->
         
         # trigger ready event.
         options.ready = true 
         element.trigger 'ready'
