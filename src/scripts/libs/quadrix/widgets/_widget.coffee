# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: _widget
# Created: 12/09/13 12.10

define [
   'jquery_ui'
   'jarvix'
   'mosaix'
   'scripts/libs/quadrix/modules/localizer'
], ($, jX, mX, localizer)->
   
   $.widget 'ui.qX__widget',
      
      options: 
         ready: false
         stylesheet: null
         class: null
         dataset: null
      
      _create: ->
         self = @

         # wait for all widgets dependencies to be ready, and for dataset to be loaded, then render.
         jX.async.parallel 
            wait: (_)-> self._wait (err)-> _(err)
            stylesheet: (_)-> 
               if self.options.stylesheet 
                  mX.load.stylesheets self.options.stylesheet
               _() 
            load: (_)-> self._load (err)-> _(err)
         , (err)->
            if err then throw err
            
            # add class to container.
            self.element.addClass self.options.class
            
            # render widget.
            self._render (err)->
               if err then throw err
               
               # localize widget the first time.
               self._localize (err)-> if err then throw err
               
               # bind events.
               $(window).on 'resize', -> self._resize (err)-> if err then throw err
               $(window).on 'localize', -> self._localize (err)-> if err then throw err
               
               # ready function (usefull for custom bindings)
               self._ready (err)-> 
                  if err then throw err
                  self.options.ready = true
                  self.element.trigger 'ready'
      
      
      _render: (callback)-> callback null
      _ready: (callback)-> callback null
      _resize: (callback)-> callback null
      
      
      _localize: (callback)-> localizer.localize @.element, (err)-> callback err
      
      
      _load: (callback)->
         self = @
         
         # understand what kind of load to do.
         if self.options.url
            mX.socket.request self.options.url, self.options.query, (err, response)->
               console.dir response

         # initialize dataset.
         self.options.dataset = self.options.dataset || []
      
         # load dataset from nested datalist tag.
         datalist = self.element.find 'datalist' 
         if datalist.length != 0
            row = {}
            jX.list.each datalist.find('option'), (option, i)->
               row.id = option.label
               row.active = option.className == 'active'
               row.data = option.value
               self.options.dataset.push row
               row = {}
            
         callback null
      
      
      _wait: (callback)->
         self = @
         element = self.element
         widgets = self.options.widgets || {}
         loaded = 0
         counted = 0
      
         require ['scripts/libs/quadrix/modules/widget'], (widget)->
            qX = widget: widget

            # count widgets.
            jX.list.each jX.object.keys(widgets), (namespace, i)->
               counted += jX.object.keys(widgets[namespace]).length
   
            # if no widget dependencies then start the plugin directly.
            if counted == 0 then return callback()
   
            # wait for widgets to be loaded.
            element.on 'waiting', (event, name)->
               loaded++
               name = name.split '.'
               namespace = name[0]
               name = name[1]
   
               # when a widget is loaded store its api in options.widgets property.
               widgets[namespace][name] = qX.widget.api widgets[namespace][name], namespace + '.' + name
   
               # if all widgets are loaded, callback.
               if counted == loaded
                  element.off 'waiting'
                  callback null
   
            
            # handle widgets loading.
            jX.list.each jX.object.keys(widgets), (namespace, i)->
               jX.list.each jX.object.keys(widgets[namespace]), (name, ii)->
                  widget = $(widgets[namespace][name])
   
                  # widget is already.
                  if widget and qX.widget.is_ready widget, namespace + '.' + name
                     element.trigger 'waiting', namespace + '.' + name
   
                     # wait for widget ready.
                  else widget.on 'ready', ->
                     element.trigger 'waiting', namespace + '.' + name;
                     widget.off 'ready'   