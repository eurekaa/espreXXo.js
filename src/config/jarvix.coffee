# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: include
# Created: 05/09/13 12.38


# ATTENTION: do not use jarvix here cause this module has to be loaded before.
jX.module.define 'config/jarvix', [], ()->
   
   
   # amd module loader configurations.
   module:
      base_path: '.'
      cache: false
      paths: {} 
      libs:
         mosaix: 
            path: 'scripts/libs/mosaix/index'
            global: false
            aliases: ['mosaix', 'mx', 'mX']
         quadrix: 
            path: 'scripts/libs/quadrix/index'
            global: false
            aliases: ['quadrix', 'qx', 'qX']
