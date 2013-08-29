# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17

define 'jarvix', [
   'async'
   'scripts/libs/jarvix/load'
   'scripts/libs/jarvix/list'
   'scripts/libs/jarvix/utility'
], (async, load, list, utility)->

   async: async
   load: load
   list: list
   utility: utility
