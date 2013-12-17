# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: global
# Created: 28/10/13 19.23


jarvix_module = if typeof window != 'undefined' then window['jarvix_memory'].module else global['jarvix_memory'].module
jarvix_module.define 'jarvix/memory', [], ->

   # define getter and setter.
   set: (name, object)->
      memory = if typeof window isnt 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
      memory[name] = object
   
   get: (name)->
      memory = if typeof window isnt 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
      memory[name]