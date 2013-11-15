# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 16/10/13 18.06


loader = if typeof window != 'undefined' then window.loader else global.loader
loader.define 'jarvix/test', [
   './module'
   './trait'
   'node://mocha'
   'node://should'
], (module, trait, mocha, should)->

   
   define: (name, dependencies, callback)->
      
      #@todo: extract object from callback and if not a function wrap in a trait.

      # wrap in a module
      module.define name, dependencies, callback
      
   describe: (name, callback)-> describe name, callback
   
   should: should
   
   run: (libraries)->
      #@todo: runs required libraries test.
     