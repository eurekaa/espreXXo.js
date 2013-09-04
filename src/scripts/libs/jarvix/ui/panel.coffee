# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


define ['jquery_ui', 'jarvix'], ($, jx) ->


   # create widget.
   $.widget 'ui.panel',


      options: 
         ready: false
         animate_out: 'bounceOutLeft'
         animate_in: 'bounceInRight'
      
      
      _create: -> @.main()
      
      
      main: ->
         self = @
         element = self.element
         options = self.options
         
         # create container to make overflow hidden.
         container = $('<div/>')
            .addClass('container')
            .html(element.html())
            .css width: element.css 'width', overflow: 'hidden'
         # append container and reference to it as main element.
         element.empty().append container
         self.element = container
         
         # trigger ready event.
         options.ready = true
         element.trigger 'ready'

      
      localize: ()->
         self = @
         element = self.element

         # localize page
         jx.localizer.localize element, (err, element)->
            if err then throw err

            # slide in page.
            self.slide element, 'bounceOutDown', 'bounceInDown', (err, element)->
               if err then throw err


      load: (url, animate_out, animate_in, callback)->
         console.log url
         self = @
         try
            # animate_out, animate_in are optional.
            if jx.utility.is_function animate_out then callback = animate_out; animate_in = self.options.animate_in; animate_out = self.options.animate_out;
            if jx.utility.is_function animate_in then callback = animate_in; animate_in = self.options.animate_in;
   
            # check arguments.
            if jx.utility.is_undefined callback then throw new Error 'a callback function must be defined.'
   
            jx.parser.destroy_widgets self.element, (err)-> 
               if err then console.error err
               if err then callback err
                  
               require ['text!' + url + '!strip'], (content)->
                  
                  jx.localizer.localize $(content), (err, content)->
                     if err then callback err

                     self.slide content, (err, content)->
                        if err then callback err

                        jx.parser.create_widgets self.element, (err, content)->                  
                           callback err, content
               
         catch err then callback err
            
                  
      slide: (content, animate_out, animate_in, callback)->
         self = @
         content = $(content)
         try
            
            # animate_out, animate_in are optional.
            if jx.utility.is_function animate_out then callback = animate_out; animate_in = self.options.animate_in; animate_out = self.options.animate_out;
            if jx.utility.is_function animate_in then callback = animate_in; animate_in = self.options.animate_in;
            
            # check arguments.
            if jx.utility.is_undefined callback then throw new Error 'a callback function must be defined.'
   
            # animate transition.
            callbacked = false
            self.element.animate_css animate_out, ->
               self.element.html content
               
               # invoke callback function once.
               if not callbacked
                  callback null, content
                  callbacked = true
               
               # animate in transition.
               self.element.animate_css animate_in
         
         catch err then callback err  