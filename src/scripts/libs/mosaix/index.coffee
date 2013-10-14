# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 01/09/13 6.32

jX = require 'jarvix'
jX.module.define 'mosaix', [
   'mosaix://load'
   'mosaix://socket'
], (load, socket)->
   
   load: load
   socket: socket