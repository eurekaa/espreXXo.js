# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: accordion
# Created: 03/09/13 21.18

define [
   'jquery_ui'
   'quadrix'
], ($, qX)->
   
   qX.widget.define 'qX.accordion',
      
      options: 
         header: 'h1'
         active: false
         collapsible: true
      
      _render: (callback)->
         @.element.accordion @.options
         callback null 

      _destroy: ->
         api = @.element.data 'ui-accordion'
         api.destroy()