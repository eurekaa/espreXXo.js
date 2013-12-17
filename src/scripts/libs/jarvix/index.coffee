# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17



# create jarvix library.
create_jarvix = (jarvix_path, module, callback)->
   
   module.require [
      'jarvix://array', 'jarvix://async', 'jarvix://config',
      'jarvix://date', 'jarvix://event', 'jarvix://library', 'jarvix://list', 
      'jarvix://memory', 'jarvix://object', 'jarvix://regexp',
      'jarvix://string', 'jarvix://test', 'jarvix://trait', 'jarvix://utility'
   ], (array, async, config, date, event, library, list, memory, 
       object, regexp, string, test, trait, utility)->
      
      callback null,
         require: (dependencies, callback)-> module.require dependencies, callback
         module: module
         array: array
         async: async
         config: config
         date: date
         event: event
         library: library
         list: list
         memory: memory
         object: object
         string: string
         test: test
         trait: trait
         utility: utility


# create global jarvix memory.
create_memory = ->
   memory = undefined
   memory_name = 'jarvix_memory'
   if typeof window isnt 'undefined' # is browser
      window[memory_name] = window[memory_name] || {}
      memory = window[memory_name]
   else # is nodejs
      global[memory_name] = global[memory_name] || {}
      memory = global[memory_name]
   return memory


# create jarvix module loader.
create_module = (define, require, callback)->
   
   # get jarvix memory.
   jarvix_memory = if typeof window != 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
   
   # create jarvix module configuration.
   #jarvix_memory.config = jarvix_memory.config || {}
   
   # configure requirejs starting with primaries needed modules.
   require.config
      paths:
         async: jarvix_memory.path + 'libs/async'
         underscore: jarvix_memory.path + 'libs/underscore'
   
   # require needed modules and define module loader.
   require ['async', 'underscore'], (async, _)->
      
      # callback defined module loader.
      callback null,
         
         options: # private props.
            requirejs: require # store requirejs original module.
            base_path: '.'
            cache: true
            paths:
               order: jarvix_memory.path + 'libs/require.order'
               use: jarvix_memory.path + 'libs/require.use'
            shim: undefined
            use: undefined
            libs:
               jarvix:
                  path: jarvix_memory['path']
                  aliases: ['jx', 'jX']
         
         config: (options, callback)->
            self = @
            
            # extend internal options.
            self.options = _.extend self.options, options
            
            #load = (config)->
               
               # configure jarvix module loader.
               #jarvix_memory.config = jarvix_memory.config or {}
               #jarvix_memory.config.module = jarvix_memory.config.module || {}
               #jarvix_memory.config.module = _.extend jarvix_memory.config.module, config

               # configure requirejs module loader.
            require.config
               baseUrl: options.base_path or '.'
               urlArgs: if typeof window isnt 'undefined' and not _.isUndefined options.cache and options.cache is false then 'v=' + (new Date()).getTime() else '' 
               paths: options.paths or {}
               shim: options.shim or {}
               use: options.use or {}
            
            if callback then callback null, options
         
            # require config file first if a string path is provided, load it directly otherwise.
            #if _.isString config then require [config], (config)-> load config
            #else load config
         
         
         resolve_paths: (paths, callback)->
            self = @
            
            # trasform into array if paths is a string.
            if _.isString paths then paths = [paths]
            
            # get registered library names (for search and replace purposes).
            libs = _.keys self.options.libs

            # resolve each path.
            async.map paths, (path, i)->
               resolved = false

               # resolve nodejs modules.
               #@todo: remove node:// dependencies if browser (from callback too)
               if path.indexOf('node://') isnt -1 or path.indexOf('nodejs://') isnt -1
                  path = path.replace('node://', '').replace('nodejs://', '')
                  resolved = true

               # resolve direct libraries names.
               if resolved isnt true and _.indexOf(libs, path) isnt -1
                  path = self.options.libs[path].path
                  resolved = true

               # resolve libraries subpaths (ex: jarvix://libs/..).
               if resolved isnt true and path.indexOf('://') isnt -1
                  sub_path = path.split '://'
                  if _.indexOf(libs, sub_path[0]) isnt -1
                     path = self.options.libs[sub_path[0]].path + sub_path[1]
                     resolved = true

               # resolve aliases (slower).
               if resolved isnt true then for lib in libs
                  aliases = self.options.libs[lib].aliases || []

                  # direct alias reference.
                  if _.indexOf(aliases, path) isnt -1
                     path = self.options.libs[lib].path
                     resolved = true

                  # alias subpath.
                  if resolved isnt true and path.indexOf '://' isnt -1
                     sub_path = path.split '://'
                     if _.indexOf(aliases, sub_path) isnt -1
                        path = self.options.libs[sub_path[0]].path + sub_path[1]
                        resolved = true

               # (if still not resolved then leave path as it is).


               # next path.
               i null, path

               # end of paths (callback resolved paths).
            , (err, paths)-> callback err, paths


         define: (name, dependencies, callback)->

            # resolve dependencies paths.
            @.resolve_paths dependencies, (err, dependencies)->
               if err then throw err
               
               # register module name only for global ones.
               #@todo: understand if library is global.
               if name is 'jarvix' or name is 'module'
                  define name, dependencies, callback

                  # ignore name, it causes error in duplicates module names.
                  # library.optimizer will add names automatically when packaging.
               else define dependencies, callback


         require: (dependencies, callback)->

            # resolve dependencies paths.
            @.resolve_paths dependencies, (err, dependencies)->
               if err then throw err

               # use raw require with internally resolved paths.
               return require dependencies, callback



# *** BROWSER SIDE SCRIPTING ***
if typeof window isnt 'undefined' # is browser.
   
   # check if jarvix has already been loaded.
   if typeof window['jarvix'] isnt 'undefined' then return false

   # create jarvix memory.
   jarvix_memory = create_memory()
   
   # retrieve jarvix path, config, and main.
   parent = document.getElementsByTagName 'script'
   parent = parent[parent.length - 1] # use last loaded script.
   jarvix_path = parent['src'].replace(window.location.href, '').replace('index.js', '')
   jarvix_config = parent.getAttribute 'data-config' || {}
   jarvix_ready = parent.getAttribute 'data-ready' || {}
   
   # globalize jarvix path.
   jarvix_memory['path'] = jarvix_path
   
   # import requirejs.
   script = document.createElement 'script'
   script['src'] = jarvix_path + 'libs/require.js'
   script.onload = ->
      
      # configure requirejs bases.
      require.onError = (err)-> console.error err
      
      # create module loader.
      create_module define, require, (err, module)->
         if err then return console.error err
         
         # configure module loader.
         ###
         module.config
            base_path: '.'
            cache: true
            libs:
               jarvix:
                  path: jarvix_memory['path']
                  aliases: ['jx', 'jX'] 
   
         ###
            
         # globalize module loader.
         jarvix_memory['module'] = module
         
         # create jarvix library.
         create_jarvix jarvix_path, module, (err, jarvix)->
            if err then return console.error err
            
            # unglobalize module loader.
            delete jarvix_memory['module']
            
            # globalize jarvix and its aliases.
            window['jarvix'] = jarvix
            window['jx'] = window['jarvix']
            window['jX'] = window['jarvix']
            
            # override optional jarvix configuration.
            jarvix.config.load jarvix_config, (err, config)->
               
               # run defined ready script.
               if jarvix.utility.is_string jarvix_ready
                  script = document.createElement 'script'
                  script['src'] = if jarvix.string.ends_with(jarvix_ready, '.js') then '' else jarvix_ready + '.js'
                  document.getElementsByTagName('head')[0].appendChild script
                  

   # append requirejs to dom.
   document.getElementsByTagName('head')[0].appendChild script




# *** NODE SIDE SCRIPTING ***
else # is nodejs
   
   exports['ready'] = (jarvix_config, callback)->
      
      # imports.
      _ = require 'underscore'
      
      # ocnfig is optional.
      if _.isFunction jarvix_config then callback = jarvix_config; jarvix_config = {}
      jarvix_config.module = jarvix_config.module or {}
      
      # create jarvix memory.
      jarvix_memory = create_memory()

      # determine and memorize jarvix path.
      base_path = module.parent.filename.split '\\'
      base_path.pop()
      jarvix_path = module.id.split '\\'
      jarvix_path.pop()
      jarvix_path = _.difference jarvix_path, base_path
      jarvix_path = jarvix_path.join('/') + '/'
      
      # globalize jarvix path.
      jarvix_memory['path'] = jarvix_path

      # import and configure requirejs.
      requirejs = require 'requirejs'
      requirejs.config
         baseUrl: '.'
         nodeRequire: require
      requirejs.onError = (err)-> console.error err
      
      # create jarvix module loader.
      create_module requirejs.define, requirejs, (err, module)->
         if err then return callback err
         
         # configure module loader.
         ###
         module.config
            cache: false
            libs:
               jarvix:
                  path: jarvix_memory['path']
                  aliases: ['jx', 'jX']
          ###
   
         # globalize module loader.
         jarvix_memory['module'] = module
         
         # create jarvix library.
         create_jarvix jarvix_path, module, (err, jarvix)->
            if err then return callback err
               
            # unglobalize module.
            delete jarvix_memory['module']

            # globalize jarvix.
            global.jarvix = jarvix
            global.jx = global.jarvix
            global.jX = global.jarvix
            
            # override optional jarvix configuration.
            jarvix.config.load jarvix_config, (err, config)->
               if err then return callback err
               
               callback null, jarvix