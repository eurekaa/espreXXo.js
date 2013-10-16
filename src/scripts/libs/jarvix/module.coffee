# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: module
# Created: 04/10/13 19.21


define [
   'sys/jarvix'
   'async'
   'underscore'
], (jY, a, u)->
   
   resolve_path: (paths, callback)->
      
      # attention: requirejs 4 node is synchronous when dependencies is a string.
      # do not turn a string dependency into an array to have it work.
      is_string = u.isString paths
      if is_string then paths = [paths]
      
      # resolve each path.
      a.map paths, (path, i)->
         
         # nodejs scheme is for convenience, remove it.
         path = path.replace 'node://', ''
         path = path.replace 'nodejs://', ''
         
         # replace libraries shortcuts with real paths (defined in sys/jarvix).
         a.each u.keys(jY.libraries), (library, ii)->
            if path.indexOf(library + '://') != -1
               path = path.replace library + '://', jY.libraries[library]
            ii null
         , (err)-> i(err, path)
         
      , (err, paths)->
         if is_string then paths = paths[0]
         callback err, paths
   
   
   define: (name, dependencies, callback)->
      
      # add directory replacement functionality.
      @.resolve_path dependencies, (err, dependencies)->
         if err then throw err
            
         # define 4 browser.
         # ignore name, it causes error in duplicates module names.
         if typeof window != 'undefined' then return define dependencies, callback

         # define 4 server (requirejs doesn't work in nodejs if a module name is defined).
         else return define dependencies, callback


   #@todo: find a way to synchronize an asynchronous function.
   # this will be useful for libraries lazy loading, not available in browser.
   require: (dependencies, callback)->
      @.resolve_path dependencies, (err, dependencies)->
         if err then throw err
         return require dependencies, callback

