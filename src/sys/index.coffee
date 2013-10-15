# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 05/09/13 12.38

jX = require 'jarvix'
jX.module.define 'system', [
   'sys://jarvix'
   'sys://mosaix'
], (jarvix, mosaix)->
   
   jarvix: jarvix
   mosaix: mosaix