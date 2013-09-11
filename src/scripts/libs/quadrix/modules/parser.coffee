# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: parser
# Created: 01/09/13 21.05

define [
   'config'
   'jquery_ui' 
   'jarvix'
   'scripts/libs/quadrix/modules/widget'
], (config, $, jX, widget)->

   qX = widget: widget
   
   
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
      try
         element = $(element)
         
         # find widgets in element.
         widgets = element.parent().find '[data-widget]' 
         
         # if no widgets return.
         if widgets.length == 0 then return callback null, element
         
         # destroy each widget.
         jX.async.each widgets, (widget_node, next)->
            try
               widget_node = $(widget_node)
               widget_name = widget_node.attr('data-widget').split '://'
               widget_namespace = widget_name[0]
               widget_name = widget_name[1]
               api = qX.widget.api widget_node, widget_namespace + '_' + widget_name
               if api then api.destroy()
               next()
            catch err then next err
         ,(err)-> callback err, element
         
         # return element.   
         callback null, element
      
      catch err then callback err, element


   parse: (element, callback)->
      self = @
      try

         element = $(element)
         
         # find all tags which defines a widget to be rendered.
         widgets = element.parent().find '[data-widget]'       
         
         # if not widgets to be run return without parsing.
         if widgets.length == 0 then return callback null, element         
         
         # render asynchronously each widget founded (they will manage dependencies by their own).
         jX.async.each widgets, (widget_node, next)->
            widget_node = $(widget_node)
            
            # calculate widget namespace, name, parameters, path and fullname.
            widget_name = widget_node.attr 'data-widget'
            widget_name = widget_name.split('?')
            widget_parameters = widget_name[1]
            widget_name = widget_name[0].split '://' 
            widget_namespace = if widget_name.length > 1 then widget_name[0] else null
            widget_name = if widget_name.length > 1 then widget_name[1] else widget_name[0]
            widget_path = if widget_namespace then config.namespaces[widget_namespace + '://'] + widget_name else widget_name               
            widget_fullname = if widget_namespace then widget_namespace + '_' + widget_name.split('/').pop() else widget_name.split('/').pop()

            # if widget is just ready jump to the next.
            if qX.widget.api widget_node, widget_fullname then return next null
            
            #@todo: parse options from query string
            widget_parameters = widget_parameters || {}
            
            # parse options from element attribute.
            widget_attributes = self.get_attributes widget_node
            widget_attributes = widget_attributes.data.options || {}
            
            # prepare widget options (parameters win plugins).
            widget_options = $.extend true, widget_attributes, widget_parameters 
            widget_options.class = widget_node.attr 'class'
            
            # require and create widget.
            require [widget_path], -> 
               try
                  # start widget.
                  widget_node[widget_fullname](widget_options)
                  
                  # next one.
                  next null, element
               catch err then next err
         
         ,(err)-> callback err, element
      catch err then callback err  