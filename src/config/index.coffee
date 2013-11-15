# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 05/09/13 12.38

jX.library.define 'config',
   jarvix_path: 'scripts/libs/jarvix/index'
,[
   'config://jarvix'
   'config://mosaix'
], (jarvix, mosaix)->
   
   jarvix: jarvix
   mosaix: mosaix