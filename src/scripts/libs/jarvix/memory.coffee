# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: global
# Created: 28/10/13 19.23


loader = if typeof window isnt 'undefined' then window.loader else global.loader
loader.define 'jarvix/memory', [], ->

   # define global memory variable.
   memory = undefined
   memory_name = 'jarvix_memory'
   if typeof window isnt 'undefined' # is browser
      window[memory_name] = window[memory_name] || {}
      memory = window[memory_name] 
   else # is nodejs
      global[memory_name] = global[memory_name] || {}
      memory = global[memory_name]
   
   
   # define getter and setter.
   set: (name, object)->
      #@todo: blind globals into traits and freeze them.
      memory[name] = object
   
   get: (name)-> memory[name]