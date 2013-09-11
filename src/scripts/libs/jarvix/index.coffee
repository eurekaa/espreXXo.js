# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17

define 'jarvix', [
   'async'
   'scripts/libs/jarvix/modules/load'
   'scripts/libs/jarvix/modules/list'
   'scripts/libs/jarvix/modules/object'
   'scripts/libs/jarvix/modules/string'
   'scripts/libs/jarvix/modules/utility'
], (async, load, list, object, string, utility)->

   async: async
   load: load
   list: list
   object: object
   string: string
   utility: utility   
