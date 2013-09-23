# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: widget
# Created: 11/09/13 20.05

define [
   'jquery_ui'
   'jarvix'
   'scripts/libs/quadrix/widgets/_widget'
], ($, jX)->
   
   define: (name, base, widget)->
      
      # base is optional.
      if not widget then widget = base; base = undefined;

      _create = (name, base, widget)->
         # isolate namespace if present.
         namespace = ''
         if jX.string.contains name, '.'
            name = name.split '.'
            namespace = if name.length > 1 then name[0] + '_' else ''
            name = if name.length > 1 then name[1] else name[0]

         # create jQuery widget under ui namaspace (the only allowed)
         # and prepend user namespace to widget name.
         $.widget 'ui.' + namespace + name, base, widget
      
      # if base not defined use qX._widget
      if not base 
         _create name, $.ui.qX__widget, widget
      else
         _create name, base, widget
            
      

   
   api: (element, widget)->
      element = $(element)
      widget = widget.replace '.', '_'
      return element.data 'ui-' + widget
   
   
   is_ready: (element, widget)->
      api = @.api element, widget
      return api and api.options.ready == true