# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: accordion
# Created: 03/09/13 21.18

define [
   'jquery_ui'
   'jarvix'
   'mosaix'
   'quadrix'
   'scrollbar'
], ($, jX, mX, qX)->

   
   qX.widget.define 'qX.scrollbar',
      
      options: 
         stylesheet: 'styles/libs/jquery/scrollbar/jquery.scrollbar.css'
      
      
      _render: (callback)->
         # create custom scrollbar.
         @.element.scrollbar()
         
         # resize for the first time.
         @._resize ->
         
         callback null
      
      
      _resize: (callback)->
         #target = self.element.parents('[data-widget]')
         @.element.css height: $(window).height() + 'px'
         
         callback null