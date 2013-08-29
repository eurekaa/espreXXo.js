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
   $.widget 'widgets.slider',


      options: {
         localizer: undefined
      }


      _init: ->
         self = @
         
         # hack: find localizer inside $.widgets registry and try to create a new instance.
         # this is not a good practice but allows me to use another plugin without passing it plugin by plugin.
         # note: the localizer.options.lang will be always the default, so localizer must use sessionStorage to
         # save current language instead of its internal options object.
         # this technique works because localizer can be used as a static class.
         if not jx.utility.is_defined self.options.localizer and jx.utility.is_defined $.widgets.localizer
            self.options.localizer = new $.widgets.localizer()
         


      load: (page, animate_in, animate_out)->

         animate = (page)->
            self.element.animate_css animate_in, ()->
               self.element.html page
               self.element.animate_css animate_out

         if jx.utility.is_string page            
            require ['text!pages/' + page.replace('.html', '') + '.html!strip'], (page)->
               if jx.utility.is_defined self.options.localizer
                  self.options.localizer.localize $(page), (err, page)->
                     if err then throw err
                     else animate $(page)
               else animate $(page)
         else animate $(page)