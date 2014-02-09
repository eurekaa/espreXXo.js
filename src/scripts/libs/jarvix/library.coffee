# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: library
# Created: 15/10/13 14.33

jarvix_memory = if typeof window isnt 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
module = if typeof jx isnt 'undefined' then jx.module else jarvix_memory['module']
define ['async', 'underscore'], (async, _)->
   
   options:
      libs: {}
   
   
   resolve_paths: (paths, callback)->

   # this function must remain synchronous.
   define: (name, options, dependencies, callback)->
      self = @
      
      # check required options.
      if not options then return callback 'options are required.'
      if not callback then callback = ->
      
      # add library info to internal options (duplicates are avoided).
      if not _.has self.options.libs, name then self.options.libs[name] = options
      
      # configure module loader with library paths.
      module.on_config
         paths: options.paths || {}
         shim: options.shim || {}
      
      # wrap in a jarvix module.
      module.define name, dependencies, callback
      

   
   config: (library, options, callback)->
      self = @

      # call each module config function with provided options,
      # then callback configured library.
      on_config = (library, options, callback)->
         modules = _.keys library
         async.each modules, (module, i)->
            if not _.isUndefined options[module] and _.isFunction library[module].on_config
               return library[module].on_config options[module], i
            else i()
         , (err)-> callback err, library
      
      # require library|options first if a string is provided.
      async.parallel [
         (callback)-> if _.isString(library) then module.require [library], (library)-> callback null, library else callback null, library
         (callback)-> if _.isString(options) then module.require [options], (options)-> callback null, options else callback null, options
      ], (err, results)->
         on_config results[0], results[1], callback
         
      
   build: (options, callback)->
      
      