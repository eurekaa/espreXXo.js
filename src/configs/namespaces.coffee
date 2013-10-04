# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: namespaces
# Created: 11/09/13 22.11

define ['configs/include'], (include)->

   'i18n://': 'i18n/'
   'tile://': 'tiles/'
   'qX://': include.paths.quadrix.replace 'index', 'widgets/' 
   
   'eK://': 'scripts/eurekaa/'