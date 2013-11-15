# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: library
# Created: 15/10/13 14.33

loader = if typeof window != 'undefined' then window.loader else global.loader
loader.define 'jarvix/library', [], ()->
   
   define: (name, config, dependencies, object)->
         
      # register library configs.
      loader.libraries[name] = config
      
      # wrap library in a module.
      loader.define name, dependencies, object