# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: widget
# Created: 11/09/13 20.05

define ['jquery_ui', 'jarvix'], ($, jX)->
   
   define: (name, widget)->
      
      # isolate namespace if present.
      namespace = ''
      if jX.string.contains name, '.'
         name = name.split '.'
         namespace = name[0]
         name = name[1]
      
      # create jQ widget under ui namaspace (the only allowed)
      # and prepend user namespace to widget name.
      $.widget 'ui.' + namespace + '_' + name, widget
   
   
   api: (element, widget)->
      element = $(element)
      widget = widget.replace '.', '_'
      return element.data 'ui-' + widget
   
   
   is_ready: (element, widget)->
      api = @.api element, widget
      return api and api.options.ready == true