# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: namespaces               s
# Created: 11/09/13 22.11

jX = require 'jarvix'
jX.module.define 'namespaces', ['sys/loader'], (loader)->

   'i18n://': 'i18n/'
   'tile://': 'tiles/'
   'qX://': loader.paths.quadrix.replace 'index', 'widgets/' 
   
   'eK://': 'scripts/eurekaa/'