# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


define ['jquery_ui', 'jarvix', 'quadrix'], ($, jX, qX) ->
   
   
   qX.widget.define 'qX.breadcrumber',
      
      options: {}
      
      
      _render: (callback)->
         @.element.html 'breadcrumber'
         callback null