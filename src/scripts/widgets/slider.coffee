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
         animate_out: 'bounceOutLeft'
         animate_in: 'bounceInRight'
      }


      _create: ->
         # preserve context.
         self = @

         # add container to make overflow hidden.
         container = $('<div/>')
            .addClass('container')
            .html(self.element.html())
            .css width: self.element.css 'width', overflow: 'hidden'
         self.element.empty().append container
         self.element = container


      slide: (page, animate_out, animate_in, callback)->
         try
            
            # animate_out, animate_in are optional.
            if jx.utility.is_function animate_out then callback = animate_out; animate_in = self.options.animate_in; animate_out = self.options.animate_out;
            if jx.utility.is_function animate_in then callback = animate_in; animate_in = self.options.animate_in;
            
            # check arguments.
            if jx.utility.is_undefined callback then throw new Error 'a callback function must be defined.'
   
            
            # animate transition.
            callbacked = false
            self.element.animate_css animate_out, ->
               self.element.html page
               
               # invoke callback function once.
               if not callbacked
                  callback null, page
                  callbacked = true
               
               # animate in transition.
               self.element.animate_css animate_in
         
         catch err then callback err  