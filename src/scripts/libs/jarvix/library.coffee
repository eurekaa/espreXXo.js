# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: library
# Created: 15/10/13 14.33

jarvix_module = if typeof window != 'undefined' then window['jarvix_memory'].module else global['jarvix_memory'].module
jarvix_module.define 'jarvix/library', [], ()->
   
   define: (name, config, dependencies, object)->
      
      # wrap library in a module.
      jarvix_module.define name, dependencies, object
      
   
   config: (options, callback)->
      