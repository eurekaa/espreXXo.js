# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: config
# Created: 02/12/13 14.00


jarvix_memory = if typeof window != 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
jarvix_memory.module.define 'jarvix/config', ['underscore'], (_)->
   
   load: (config, callback)->
      self = @
      
      # extend default configuration with provided ones, save in jarvix memory, then callback.
      load = (config)->
         self = _.extend self, config
         delete self.load
         jarvix_memory.config = self
         if callback then callback null, config
      
      #@todo: run all modules config function.
      
      # require config file first if a string path is provided, load it directly otherwise.
      if _.isString config then require [config], (config)-> load config
      else load config
