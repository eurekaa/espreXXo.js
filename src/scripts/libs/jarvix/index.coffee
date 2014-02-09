# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17



# create jarvix library.
create_jarvix = (jarvix_path, module, library, callback)->
   
   # define jarvix library.
   library.define 'jarvix', 
      version: '1.0.0'
      aliases: ['jx', 'jX']
      global: true
      base_path: jarvix_path
      test_path: jarvix_path + 'tests/'
      doc_path: jarvix_path + 'docs/'
      paths:
         order: jarvix_path + 'libs/require.order'
         use: jarvix_path + 'libs/require.use'
         async: jarvix_path + 'libs/async'
         eventify: jarvix_path + 'libs/eventify'
         underscore: jarvix_path + 'libs/lodash'
         moment: jarvix_path + 'libs/moment'
         traits: jarvix_path + 'libs/traits'
         chai: jarvix_path + 'libs/chai'
         mocha: 'http://cdnjs.cloudflare.com/ajax/libs/mocha/1.13.0/mocha.min'
      shim: {}
      use: {}
   , [
      jarvix_path + 'array', jarvix_path + 'async', jarvix_path + 'config',
      jarvix_path + 'date', jarvix_path + 'event', jarvix_path + 'list',
      jarvix_path + 'memory', jarvix_path + 'object', jarvix_path + 'regexp',
      jarvix_path + 'string', jarvix_path + 'test', jarvix_path + 'trait', 
      jarvix_path + 'utility'
   ], (array, async, config, date, event, list, memory, object, regexp, string, test, trait, utility)->

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
   
   # require and callback jarvix.
   module.require ['jarvix'], (jx)-> callback null, jx



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
   jarvix_memory = if typeof window isnt 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
   
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
            cache: false #@todo: reset to true!
            paths: {}
            shim: {}
            use: {}
         
         
         on_config: (options, callback)->
            self = @
            options = options || {}
            
            # for security reasons, some options could be added, but not overrided.
            options.paths = _.omit options.paths, _.keys(self.options.paths)
            options.shim = _.omit options.shim, _.keys(self.options.shim)
            options.use = _.omit options.use, _.keys(self.options.use)
            
            # extend internal options.
            self.options = _.extend self.options, options
            
            url_args = ''
            if typeof window isnt 'undefined'
               if self.options.cache is false
                  url_args = 'v=' + (new Date()).getTime()
            
            # nodejs doesn't need a cache.
            else self.options.cache = true

            # configure requirejs module loader.
            require.config
               baseUrl: self.options.base_path or '.'
               urlArgs: url_args  
               paths: self.options.paths or {}
               shim: self.options.shim or {}
               use: self.options.use or {}
            
            if callback then callback null, options
         
         
         resolve_paths: (paths, callback)->
            self = @
            
            # trasform into array if paths is a string.
            if _.isString paths then paths = [paths]
            
            # get list of registered libraries; 
            libs = if typeof jx isnt 'undefined' then jx.library.options.libs else {}
            libs_names = _.keys libs

            # resolve client|server switch.
            if typeof window isnt 'undefined' 
               paths = paths.client or paths.browser or paths 
            else 
               paths = paths.server or paths.node or paths
            
            # resolve each path.
            async.map paths, (path, i)->
               resolved = false
               
               #@todo: use jx.library.options.libs
               # salvare in jx.library.options anche l'istanza della libreria.
               # da servire poi nel loader senza usare requirejs.
               
               # resolve nodejs modules.
               #@todo: remove node:// dependencies if browser (from callback too)
               if path.indexOf('node://') isnt -1 or path.indexOf('node_modules://') isnt -1
                  path = path.replace('node://', '').replace('node_modules://', '')
                  resolved = true

               # resolve direct libraries names.
               if resolved isnt true and _.indexOf(libs_names, path) isnt -1
                  path = libs[path].base_path
                  resolved = true

               # resolve libraries subpaths (ex: jarvix://libs/..).
               if resolved isnt true and path.indexOf('://') isnt -1
                  sub_path = path.split '://'
                  if _.indexOf(libs_names, sub_path[0]) isnt -1
                     path = libs[sub_path[0]].base_path + sub_path[1]
                     resolved = true

               # resolve aliases (slower).
               if resolved isnt true then for name in libs_names
                  aliases = libs[name].aliases || []

                  # direct alias reference.
                  if _.indexOf(aliases, path) isnt -1
                     path = libs[name].base_path
                     resolved = true

                  # alias subpath.
                  if resolved isnt true and path.indexOf '://' isnt -1
                     sub_path = path.split '://'
                     if _.indexOf(aliases, sub_path) isnt -1
                        path = libs[sub_path[0]].base_path + sub_path[1]
                        resolved = true  
               
               # next path.
               i null, path
               

            # end of paths (callback resolved paths).
            , (err, paths)->
               #console.log paths
               callback err, paths


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
               else
                  define dependencies, callback


         require: (dependencies, callback)->

            # resolve dependencies paths.
            @.resolve_paths dependencies, (err, dependencies)->
               if err then throw err

               # use raw require with internally resolved paths.
               return require dependencies, callback



# *** BROWSER SIDE SCRIPTING ***
if typeof window isnt 'undefined' # is browser.
   
   # check if jarvix has already been loaded.
   #if typeof window['jarvix'] isnt 'undefined' then return false

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
         
         # globalize module loader.
         jarvix_memory['module'] = module
         
         # create jarvix library.
         module.require [jarvix_path + 'library'], (library)->
            create_jarvix jarvix_path, module, library, (err, jarvix)->
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
         
         # globalize module loader.
         jarvix_memory['module'] = module
         
         # create jarvix library.
         module.require [jarvix_path + 'library'], (library)->
            create_jarvix jarvix_path, module, library, (err, jarvix)->
               if err then return console.error err
                  
               # unglobalize module.
               delete jarvix_memory['module']
               
               # globalize jarvix.
               global.jarvix = jarvix
               global.jx = global.jarvix
               global.jX = global.jarvix
               
               # override optional jarvix configuration.
               jarvix.config.load jarvix_config, (err)-> callback err, jarvix