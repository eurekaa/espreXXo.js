# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: async
# Created: 01/10/13 20.38

jarvix_memory = if typeof window != 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
jarvix_module = jarvix_memory.module   
jarvix_module.define 'jarvix/async', ['async'], (a)->
   
   if: (condition, action, callback)->
      if condition then action.then callback
      else action.else callback
         
   each: a.each
   parallel: a.parallel
   series: a.series
   map: a.map