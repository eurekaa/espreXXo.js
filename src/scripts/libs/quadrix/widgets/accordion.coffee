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
         ready: false
         header: 'h1'
         active: false
         collapsible: true
      
      _create: ->
         @.element.accordion @.options
         
         @.options.ready = true
         @.element.trigger 'ready'  

      _destroy: ->
         api = @.element.data 'ui-accordion'
         api.destroy()