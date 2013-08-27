# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17

define 'jarvix', [   
   'scripts/libs/jarvix/load'
   'scripts/libs/jarvix/i18n'
   'scripts/libs/jarvix/list'
   'scripts/libs/jarvix/utility'
], (load, i18n, list, utility)->

   i18n: i18n
   load: load
   list: list
   utility: utility
