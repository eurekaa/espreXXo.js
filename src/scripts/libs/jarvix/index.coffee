# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17


# define global loader variable. @todo: find a way to remove it.
loader = undefined

# define gloabl jX library.


# *** CLIENT SIDE SCRIPTING. ***
if typeof window != 'undefined' # is browser
   script = document.createElement 'script'
   script.src = 'scripts/libs/jarvix/modules/module.js'
   document.getElementsByTagName('head')[0].appendChild script
   #@todo: find a way to use callbacks, look at require.js code.
   setTimeout ->
      loader.define jX 
   , 10000


# *** SERVER SIDE SCRIPTING. ***
else # is nodejs
   
   requirejs = require 'requirejs'
   module = requirejs 'scripts/libs/jarvix/modules/module'

   jX = module.define 'jarvix', [], ->
      module: module
      async: module.require 'scripts/libs/jarvix/modules/async'
      list: module.require 'scripts/libs/jarvix/modules/list'
      object: module.require 'scripts/libs/jarvix/modules/object'
      string: module.require 'scripts/libs/jarvix/modules/string'
      utility: module.require 'scripts/libs/jarvix/modules/utility'