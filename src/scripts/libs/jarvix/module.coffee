# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: module
# Created: 04/10/13 19.21



create_loader = (define, require, jarvix_path, async, utility)->
   
   raw_require: require
   libraries:
      jarvix:
         jarvix_path: jarvix_path + 'index'
   
   
   resolve_path: (paths, callback)->
      self = @
      
      # attention: requirejs 4 node is synchronous when dependencies is a string.
      # do not turn a string dependency into an array to have it work.
      is_string = utility.isString paths
      if is_string then paths = [paths]
      
      # resolve each path.
      async.map paths, (path, i)->
         
         # nodejs scheme is for convenience, remove it.
         #@todo: remove node:// dependencies if browser (from callback too)
         path = path.replace 'node://', ''
         path = path.replace 'nodejs://', ''
         
         # replace libraries shortcuts with real paths. 
         async.each utility.keys(self.libraries), (library, ii)->
            
            # replace library name direct call.
            if(path.indexOf(library) != -1 and path.indexOf('/') == -1)
               path = self.libraries[library].jarvix_path.replace 'jarvix/index', library + '/index'
            
            # replace library subpath. 
            else if path.indexOf(library + '://') != -1
               path = path.replace library + '://', self.libraries[library].jarvix_path.replace 'jarvix/index', library + '/'
            
            # next library.
            ii null, library
         
         # next path.
         , (err)-> i err, path

      # callback resolved paths.
      , (err, paths)->
         if is_string then paths = paths[0]
         callback err, paths


   define: (name, dependencies, callback)->
      
      # add directory replacement functionality.
      @.resolve_path dependencies, (err, dependencies)->
         if err then throw err
         
         # register module name only for global ones.
         if name is 'jarvix' or name is 'module'
            define name, dependencies, callback
         
         # ignore name, it causes error in duplicates module names.
         # library.optimizer will add names automatically when packaging.
         else define dependencies, callback
   
   
   #@todo: find a way to synchronize an asynchronous function.
   # this will be useful for libraries lazy loading, not available in browser.
   require: (dependencies, callback)->
      @.resolve_path dependencies, (err, dependencies)->
         if err then throw err
         return require dependencies, callback


   

# *** CLIENT SIDE SCRIPTING (run once when jarvix is loaded). ***
if typeof window isnt 'undefined' # is browser
   
   # get jarvix path.
   jarvix_path = window.jarvix_path
   
   # get parent script tag (the latest loaded).
   parent = document.getElementsByTagName 'script'
   parent = parent[parent.length - 1]
   
   # prepare to import requirejs.
   script = document.createElement 'script'
   script.src = jarvix_path + 'libs/require.js'
   script.onload = ->
      
      # configure requirejs bases 
      # (shortcuts will be resolved internally by jX.module.resolve_paths(...).
      require.config
         baseUrl: '.'
         urlArgs: 'v=' + (new Date()).getTime()
         paths:
            domready: jarvix_path + 'libs/require.domready'
            async: jarvix_path + 'libs/async'
            eventify: jarvix_path + 'libs/eventify'
            underscore: jarvix_path + 'libs/underscore'
            traits: jarvix_path + 'libs/traits'
      
      # error handling.
      require.onError = (err)-> console.dir err
      
      # require dependencies for loader creation.
      require ['async', 'underscore', jarvix_path + 'memory'], (async, utility, memory)->
         
         # globalize loader.
         memory.set 'loader', create_loader define, require, jarvix_path, async, utility
         
         # trigger ready event.
         parent.dispatchEvent new Event 'ready'
   
   # append requirejs to dom.
   document.getElementsByTagName('head')[0].appendChild script



# *** SERVER SIDE SCRIPTING ***
else # is nodejs.
   
   async = require 'async'  
   utility = require 'underscore' 
   
   # import and configure requirejs.
   requirejs = require 'requirejs' 
   requirejs.config
      baseUrl: '.'
      urlArgs: '' # requirejs 4 node doesn't support urlArgs.
      nodeRequire: require
   
   #requirejs.onError = (err)-> console.dir err
   
   # create and globalize loader.
   global.loader  = create_loader requirejs.define, requirejs, global.jarvix_path, async, utility
   
   # commonjs support.
   if typeof module != 'undefined' and module.exports then module.exports = global.loader

   global.trigger 'module:ready'
   # amd support.
   #else global.loader.define 'module', [], -> global.loader

