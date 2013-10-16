# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 16/10/13 18.06

define ['require', 'mocha', 'should', './trait', './module'], 
(require, mocha, trait, should, module)->
   
   define: (name, dependencies, callback)->
      
      #@todo: extract object from callback and if not a function wrap in a trait.

      # wrap in a module
      module.define name, dependencies, callback
      
   describe: (name, callback)-> describe name, callback
   
   should: should
     