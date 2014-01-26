# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: library
# Created: 15/10/13 14.33

jarvix_memory = if typeof window isnt 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
define ['async', 'underscore'], (async, _)->
   
   options:
      libs: {}
   
   
   resolve_paths: (paths, callback)->
   
      
   #todo: ATTENZIONE!
   # per evitare di tenere in memoria istanze di librerie,
   # salvare le options di ogni modulo nella jarvix memory.
   # quando viene richiesto un modulo viene fornita la versione statica
   # dalla cache di requirejs, ma leggerà le options dalla memoria, 
   # in questo modo l'istanza sarà mantenuta viva.

   
   define: (name, options, dependencies, callback)->
      self = @
      
      # check required options.
      if not options then return callback 'options are required.'
      if not callback then callback = ->
      
      # add library info to internal options (duplicates are avoided).
      if not _.has self.options.libs, name then self.options.libs[name] = options
      
      # configure loader about library paths.
      module = if typeof jx isnt 'undefined' then jx.module else jarvix_memory['module']
      module.config
         paths: options.paths || {}
         shim: options.shim || {}
      
      # wrap in a jarvix module.
      module.define name, dependencies, callback
      

   
   config: (library, options, callback)->
      self = @
      
      
      
      library = self.options.libs[library]
      modules = _.keys library
      async.each modules, (module, i)->
         if not _.isUndefined options[module] 
            if typeof jx isnt 'undefined' then  
            else jarvix_memory['library']
               jx.memory.set ''
            _.extend jarvix_memory['library']
            
            
      
      
      
      
      
      
      
   build: (options, callback)->
      
      