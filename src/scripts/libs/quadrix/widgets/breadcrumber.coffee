# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


jX = require 'jarvix'
jX.module.define 'breadcrumber', [
   'jquery_ui'
   'quadrix'
], ($, qX) ->
   
   
   qX.element.define 'qX.breadcrumber',
      
      options: {}
      
      
      _render: (callback)->
         @.element.html 'breadcrumber'
         callback null