# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 01/09/13 6.32

jX = require 'jarvix'
jX.module.define 'mosaix', [
   'scripts/libs/mosaix/modules/load'
   'scripts/libs/mosaix/modules/socket'
], (load, socket)->
   
   load: load
   socket: socket