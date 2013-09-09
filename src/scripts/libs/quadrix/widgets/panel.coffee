# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


define ['jquery_ui', 'jarvix', 'quadrix'], ($, jX, qX) ->


   # create widget.
   $.widget 'qX.qX_panel',


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
         qX.localizer.localize element, (err, element)->
            if err then throw err

            # slide in page.
            self.change element, 'bounceOutDown', 'bounceInDown', (err, element)->
               if err then throw err


      load: (url, animate_out, animate_in, callback)->
         self = @
         try
            # animate_out, animate_in are optional.
            if jX.utility.is_function animate_out then callback = animate_out; animate_in = self.options.animate_in; animate_out = self.options.animate_out;
            if jX.utility.is_function animate_in then callback = animate_in; animate_in = self.options.animate_in;
   
            # check arguments.
            if jX.utility.is_undefined callback then throw new Error 'a callback function must be defined.'
   
            # localize, visualize and run widgets on new page.
            content = null
            jX.async.series
               animate_out: (_)-> self.animate animate_out, (err)-> self.element.css visibility: 'hidden'; _(err)
               require: (_)-> require ['text!' + url + '!strip'], (file)-> content = $(file); _(null, content)
               localize: (_)-> qX.localizer.localize content, (err)-> _(err)
               destroy: (_)-> qX.parser.unparse self.element, (err)-> _(err)
               parse: (_)-> self.element.html content; qX.parser.parse self.element, (err)-> _(err)
               animate_in: (_)-> self.animate animate_in, (err)-> _(err)
            , (err) -> callback err
         
         catch err then callback err


      animate: (animation, callback)->
         self = @
         try

            # slide animation invoke callback function once.
            callbacked = false
            self.element.animate_css animation, ->
               if not callbacked then callback null; callbacked = true
         
         catch err then callback err
            

      change: (content, animate_out, animate_in, callback)->
         self = @
         content = $(content)
         try
            
            # animate_out, animate_in are optional.
            if jX.utility.is_function animate_out then callback = animate_out; animate_in = self.options.animate_in; animate_out = self.options.animate_out;
            if jX.utility.is_function animate_in then callback = animate_in; animate_in = self.options.animate_in;
            
            # check arguments.
            if jX.utility.is_undefined callback then throw new Error 'a callback function must be defined.'
   
            # animate transition.
            callbacked = false
            self.animate animate_out, ->
               self.element.html content
               
               # invoke callback function once.
               if not callbacked
                  callback null, content
                  callbacked = true
               
               # animate in transition.
               self.animate animate_in
         
         catch err then callback err  