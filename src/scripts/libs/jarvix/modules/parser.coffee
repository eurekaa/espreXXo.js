# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: parser
# Created: 01/09/13 21.05

define ['jquery' 
        'async' 
        'scripts/libs/jarvix/modules/list'
        'scripts/libs/jarvix/modules/string'
        'scripts/libs/jarvix/modules/utility'
], ($, async, list, string, utility)->


   # reads all attributes and return them in an tree nested object.
   get_attributes: (element)->
      attributes = {}
      
      # loop over all parts of the name (used as object key paths)
      list.each element.context.attributes, (attribute, i)->
         
         # scompose attribute name path.
         list.each attribute.name.split('-'), (key, ii, keys)->
            
            # create nested object tree (separator is -)
            if ii != (keys.length - 1)
               key = keys.slice(0, ii+1).join('.')
               eval 'attributes.' + key + ' = attributes.' + key + ' || {};'
            else 
               eval 'attributes.' + keys.join('.') + ' = attribute.value;'
   
      return attributes


   destroy_widgets: (element, callback)->
      element = $(element)
      try
         
         # find widgets in element.
         widgets = element.find '[data-widget]'
         
         # if no widgets return.
         if widgets.length == 0 then return callback null, element
         
         # destroy each widget.
         async.each widgets, (widget, next)->
            try               
               widget = $(widget)
               widget_name = widget.attr('data-widget').split('/')
               widget = widget.data 'ui-' + widget_name.pop()
               if widget then widget.destroy()                             
            catch err then next err
         ,(err)-> callback err, element
         
         # return element.   
         callback null, element
      
      catch err then callback err, element


   create_widgets: (element, callback)->
      self = @
      element = $(element)
      try
      
         # find all tags which defines a widget to be rendered.
         widgets = element.find '[data-widget]'
         
         # if not widgets to be run return without parsing.
         if widgets.length == 0 then return callback null, element
         
         # render asynchronously each widget founded (they will manage dependencies by their own).
         async.each widgets, (node, callback)->
            node = $(node)
            
            # get widget name and resolve jarvix path if present.
            widget = node.attr 'data-widget'
            widget = widget.split('?')
            parameters = widget[1]
            widget = widget[0].replace 'jarvix://', 'scripts/libs/jarvix/'
            
            #@todo: parse options from query string
            parameters = parameters || {}
            
            # parse options from element attribute.
            attributes = self.get_attributes node
            attributes = attributes.data.options || {}
            
            # prepare widget options (parameters win plugins).
            options = $.extend true, attributes, parameters 
            options.class = node.attr 'class'
            
            # require and create widget.
            require [widget], -> 
               try
                  eval 'node.' + widget.split('/').pop() + '(options)'
                  callback null, element
               catch err then callback err  
         ,(err)-> callback err, element
      catch err then callback err  