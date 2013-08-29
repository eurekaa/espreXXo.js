# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


define ['jquery_ui', 'jarvix'], ($, jx) ->


   # create widget.
   self = undefined
   $.widget 'widgets.breadcrumber',


      options: {}


      _create: ->
