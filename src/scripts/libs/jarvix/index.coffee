# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17



define [
   'scripts/libs/jarvix/module'
   'scripts/libs/jarvix/async'
   'scripts/libs/jarvix/library'
   'scripts/libs/jarvix/list'
   'scripts/libs/jarvix/object'
   'scripts/libs/jarvix/string'
   'scripts/libs/jarvix/utility'
], (module, async, library, list, object, string, utility)->

   module: module
   require: (dependencies, callback)-> module.require dependencies, callback
   async: async
   library: library
   list: list 
   object: object
   string: string 
   utility: utility