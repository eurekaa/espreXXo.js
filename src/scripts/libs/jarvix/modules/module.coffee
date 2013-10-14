# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: module
# Created: 04/10/13 19.21


# define global loader variable.
loader = undefined

# *** CLIENT SIDE SCRIPTING. ***
if typeof window != 'undefined' # is browser
   
   # import browser requirejs library for amd management.
   script = document.createElement 'script'
   script.src = 'scripts/libs/jarvix/libs/require.js'
   document.getElementsByTagName('head')[0].appendChild script
   
   # wait for requirejs to be loaded.
   #@todo: find a way to use callbacks, look at require.js code. 
   setTimeout ->
      
      # configure requirejs.
      config = require 'configs/require'
      require.config config
      
      # define global module loader.
      loader = define 'module', [], ->
         define: (name, dependencies, callback)-> define name, dependencies, callback
         require: (dependencies, callback)-> require dependencies, callback
      
      #@todo: remove global requirejs loader.
      
   , 2000


# *** SERVER SIDE SCRIPTING. ***
else # is nodejs
   
   # import node requirejs library for am management.
   requirejs = require 'requirejs'
   
   # configure requirejs.
   #@todo: find a way to configure requirejs here (not in espreXXO.js).
   
   # define module loader.
   requirejs.define [], ->
      
      
      define: (name, dependencies, module)->
         
         # check if name is passed.
         #if not module then throw new Error 'you must specify a module name'
         
         if typeof window is not 'undefined' # is browser
            requirejs.define name, dependencies, module
         
         else # is nodejs
            # requirejs 4 node doesn't work if a name is passed. 
            requirejs.define dependencies, module
      
      
      require: (dependencies, module)->
         
         # attention: requirejs 4 node is synchronous only when dependencies is a string.
         # do not turn dependencies into an array (if a string) 
         # for dinamically loaded parts of jX to work.
         return requirejs dependencies, module
