# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17

define [
   'async'
   'scripts/libs/jarvix/modules/async'
   'scripts/libs/jarvix/modules/list'
   'scripts/libs/jarvix/modules/object'
   'scripts/libs/jarvix/modules/string'
   'scripts/libs/jarvix/modules/utility'
], (async, jx_async, list, object, string, utility)->
   
   # add conditional async execution.
   async.if = jx_async.if
   
   async: async
   list: list
   object: object
   string: string
   utility: utility
   
   require: (module_name)->
      if utility.is_nodejs
         module_name = module_name.split('?')[0]
         requirejs = require 'requirejs'
         requirejs module_name 
      else
         require module_name
