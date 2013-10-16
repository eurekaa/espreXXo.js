# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17



define [
   'require'
   'scripts/libs/jarvix/module'
   'scripts/libs/jarvix/async'
   'scripts/libs/jarvix/library'
   'scripts/libs/jarvix/list'
   'scripts/libs/jarvix/object'
   'scripts/libs/jarvix/string'
   'scripts/libs/jarvix/test'
   'scripts/libs/jarvix/trait'
   'scripts/libs/jarvix/utility'
], (require, module, async, library, list, object, string, test, trait, utility)->

   jX = 
      require: (dependencies, callback)-> module.require dependencies, callback
      module: module
      async: async
      library: library
      list: list 
      object: object
      string: string
      test: test
      trait: trait
      utility: utility
   
   # commonjs support.
   if typeof exports != 'undefined'
      exports['jarvix'] = jX
      exports['jX'] = jX
      exports['jx'] = jX
   
   return jX