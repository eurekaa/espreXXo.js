# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: event
# Created: 21/10/13 15.34


# get module loader and info from memory.
jarvix_memory = if typeof window != 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
jarvix_path = jarvix_memory.path
jarvix_module = jarvix_memory.module

# define event module.
jarvix_module.define 'jarvix/event', ['eventify'], (eventify)->
###
   enable: ->
   on: eventify.on
   off: eventify.off
   trigger: eventify.trigger
   
###