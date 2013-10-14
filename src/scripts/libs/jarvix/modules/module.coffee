# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: module
# Created: 04/10/13 19.21


define [
   'sys/loader'
   'async'
   'underscore' 
], (loader_config, async, utility)->

   define: (name, dependencies, module)->
      
      # check if name is passed.
      if not name then throw new Error 'you must specify a module name'
      
      # add directory replacement functionality.
      async.map dependencies, (dependency, i)->
         # ignore nodejs directory, requirejs has not to llok inside that directory!
         dependency = dependency.replace 'node://', ''
         dependency = dependency.replace 'nodejs://', ''
         
         # replace directory shortcuts with real paths (defined in sys/loader).
         async.each utility.keys(loader_config.directories), (directory, ii)->
            if dependency.indexOf(directory + '://') != -1
               dependency = dependency.replace directory + '://', loader_config.directories[directory]
            ii null
         , (err)-> i(err, dependency)
         
      , (err, dependencies)-> 
         if err then throw err
         
         # define 4 browser.
         if typeof window is not 'undefined' then return define name, dependencies, module
   
         # define 4 server (requirejs doesn't work in nodejs if a module name is defined).
         else return define dependencies, module


   require: (dependencies, module)->

      # attention: requirejs 4 node is synchronous when dependencies is a string.
      # do not turn dependencies into an array (if a string) to have it work. 
      return require dependencies, module

