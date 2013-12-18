# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: library
# Created: 15/10/13 14.33

jarvix_memory = if typeof window != 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
jarvix_module = jarvix_memory['module']
jarvix_module.define 'jarvix/library', ['underscore'], (_)->
   
   options:
      libs: 
         jarvix:
            name: 'jarvix'
            path: jarvix_memory['path']
            globalize: true # or ['jx', 'jX']
            aliases: ['jx', 'jX']
            libs: undefined
   
   define: (name, options)->
      self = @
      
      # check required options.
      if not options then return false
      if not options.name then return false
      
      # add library info to internals (allowed only).
      self.options.libs[options.name] = {}
      self.options.libs[options.name].modules = options.modules || {}

      # create library.
      library = {}
      
      # find dependecies to load.
      lib = self.options.libs[options.name] 
      modules = _.keys lib.modules
      paths = []
      for module in modules 
         if typeof lib.modules[module] is 'string' then paths.push lib.modules[module]
         else library[module] = lib.modules[module]

      jarvix_module.define name, [], options
      ###
      return jarvix_module.define name, paths, ->
         for module in modules when typeof lib.modules[module] is 'string'  
            console.log module
            library[module] = arguments[0]
            
            return library
       ###
   
   config: (options, callback)->
      
      