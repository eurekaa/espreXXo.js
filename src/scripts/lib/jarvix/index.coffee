# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17

define 'jarvix', [   
   'scripts/lib/jarvix/load'
   'scripts/lib/jarvix/i18n'
   'scripts/lib/jarvix/list'
   'scripts/lib/jarvix/utility'
], (load, i18n, list, utility)->

   i18n: i18n
   load: load
   list: list
   utility: utility
