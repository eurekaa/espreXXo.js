# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 22/08/13 17.17

create_jarvix = (loader, callback)->
   
   # define jarvix library.
   loader.require [ 
      'jarvix://array', 'jarvix://async',
      'jarvix://library', 'jarvix://list', 'jarvix://memory', 
      'jarvix://object', 'jarvix://string',
      'jarvix://trait', 'jarvix://utility'
   ], (array, async, library, list, memory, object, string, trait, utility)->
      callback
         require: (dependencies, callback)-> loader.require dependencies, callback
         module: loader
         array: array
         async: async
         library: library
         list: list
         memory: memory
         object: object
         string: string
         trait: trait
         utility: utility



# *** BROWSER SIDE SCRIPTING ***
if typeof window isnt 'undefined' # is browser.
   
   # get parent script tag (the latest loaded).
   parent = document.getElementsByTagName 'script'
   parent = parent[parent.length - 1]
   
   # determine and globalize jarvix path.
   window.jarvix_path = parent.src.replace 'index.js', ''
   window.jarvix_path = window.jarvix_path.replace window.location.href, ''
   
   # import jarvix module loader.
   script = document.createElement 'script'
   script.src = window.jarvix_path + 'module.js'

   script.addEventListener "ready", (event)->
      try
         # create global jX library.
         create_jarvix window['jarvix_memory'].loader, (jX)->
            window.jX = jX
         
            # trigger ready event.
            parent.dispatchEvent new Event 'ready'
         
      catch err then console.error err
   , false
   
   document.getElementsByTagName('head')[0].appendChild script



# *** NODE SIDE SCRIPTING ***
else # is nodejs
   utility = require 'underscore'

   # eventify global object.
   eventify = require 'eventify'
   eventify.enable global

   # determine and globalize jarvix and base path.
   base_path = module.parent.filename.split '\\'
   jarvix_path = module.id.split '\\'
   jarvix_path = utility.difference(jarvix_path, base_path)
   jarvix_path.pop()
   jarvix_path = jarvix_path.join '/'
   jarvix_path += '/'
   global.jarvix_path = jarvix_path

   # when module is ready create and globalize jarvix library.
   global.on 'module:ready', ->
      create_jarvix global.loader, (jX)->
         
         # globalize jarvix.
         global.jX = jX

         # trigger ready event.
         global.trigger 'jarvix:ready'
         
         # commonjs support.
         if typeof module != 'undefined' and module.exports then module.exports = jX
         
         # amd support.
         else loader.define 'jarvix', [], -> jX

   # require and globalize loader.
   if typeof global.loader == 'undefined' then global.loader = require './module'  