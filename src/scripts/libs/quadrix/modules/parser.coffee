# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: parser
# Created: 01/09/13 21.05

define [
   'config'
   'jquery' 
   'jarvix'
   'quadrix'
], (config, $, jX, qX)->


   # reads all attributes and return them in an tree nested object.
   get_attributes: (element)->
      attributes = {}
      
      # loop over all parts of the name (used as object key paths)
      jX.list.each element.context.attributes, (attribute, i)->
         
         # preserve qX case. #@todo: preserve all cases!
         name = attribute.name.replace 'qx', 'qX'
         
         # scompose attribute name path.
         jX.list.each name.split('-'), (key, ii, keys)->
            
            # create nested object tree (separator is -)
            if ii != (keys.length - 1)
               key = keys.slice(0, ii+1).join('.')
               eval 'attributes.' + key + ' = attributes.' + key + ' || {};'
            
            # append leaf value.
            else 
               eval 'attributes.' + keys.join('.') + ' = attribute.value;'
   
      return attributes


   unparse: (element, callback)->
      element = $(element)
      try
         
         # find widgets in element.
         widgets = element.find '[data-widget]'
         
         # if no widgets return.
         if widgets.length == 0 then return callback null, element
         
         # destroy each widget.
         jX.async.each widgets, (widget, next)->
            try               
               widget = $(widget)
               widget_name = widget.attr('data-widget').split('/')
               widget = widget.data 'qX-qX_' + widget_name.pop()
               if widget then widget.destroy()
            catch err then next err
         ,(err)-> callback err, element
         
         # return element.   
         callback null, element
      
      catch err then callback err, element


   parse: (element, callback)->
      self = @
      element = $(element)
      try
      
         # find all tags which defines a widget to be rendered.
         widgets = element.parent().find '[data-widget]'
         #if widgets.length == 0 then widgets = element.find '[data-widget]'
         
         # if not widgets to be run return without parsing.
         if widgets.length == 0 then return callback null, element         
         
         # render asynchronously each widget founded (they will manage dependencies by their own).
         jX.async.each widgets, (node, next)->
            node = $(node)
            
            # get widget name and resolve jarvix path if present.
            widget = node.attr 'data-widget'
            widget = widget.split('?')
            parameters = widget[1]
            widget = widget[0]
            is_qX = (widget.indexOf('qX://') != -1 or widget.indexOf('qX.') != -1)
            if is_qX == true
               widget = widget.replace('qX://', config.require.paths.quadrix.replace 'index', 'widgets/')
               widget = widget.replace('qX.', config.require.paths.quadrix.replace 'index', 'widgets/')
            widget = widget.split('/')
            widget_name = widget.pop()
            widget_path = widget.join('/')
            
            # if widget is just ready jump to the next.
            if is_qX == true and node.data 'qX-qX_' + widget_name then return next null
            else if node.data 'ui-' + widget_name then return next null            
            
            #@todo: parse options from query string
            parameters = parameters || {}
            
            # parse options from element attribute.
            attributes = self.get_attributes node
            attributes = attributes.data.options || {}
            
            # prepare widget options (parameters win plugins).
            options = $.extend true, attributes, parameters 
            options.class = node.attr 'class'
            
            # require and create widget.
            require [widget_path + '/' + widget_name], -> 
               try
                  # start widget.
                  if is_qX == true
                     node.qX widget_name, options, (api)->
                  else 
                     node[widget_name](options)
                     
                  # next one.                  
                  next null, element
               catch err then next err
         
         ,(err)-> callback err, element
      catch err then callback err  