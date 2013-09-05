# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: accordion
# Created: 03/09/13 21.18

define ['jquery_ui', 'jarvix', 'scrollbar'], ($, jX)->

   jX.load.stylesheets ['styles/libs/jquery/scrollbar/jquery.scrollbar.css']
   
   $.widget 'qX._scrollbar',
      
      options: 
         ready: false
      
      _create: ->
         self = @             

         # resize scrollbar when window is resized.
         $(window).on 'resize', (event)->
            console.dir event
            #target = self.element.parents('[data-widget]')
            self.element.css height: $(window).height() + 'px'

         # create custom scrollbar.
         self.element.scrollbar()
         $(window).trigger 'resize'

         # trigger ready event.
         self.options.ready = true
         self.element.trigger 'ready'