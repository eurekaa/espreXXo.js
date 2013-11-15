# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: include
# Created: 05/09/13 12.38


# ATTENTION: do not use jarvix here cause this module has to be loaded before.
jX.module.define 'config/jarvix', [], ()->
   
   environment: 'debug'

   # amd loader configuration.
   loader:
      libraries:
         jarvix:
            index: 'scripts/libs/jarvix/index'
            libs:
               domready: 'scripts/libs/jarvix/libs/require.domready'
               async: 'scripts/libs/jarvix/libs/async'
               eventify: 'scripts/libs/jarvix/libs/eventify'
               underscore: 'scripts/libs/jarvix/libs/underscore'
               traits: 'scripts/libs/jarvix/libs/traits'
         mosaix: 
            index: 'scripts/libs/mosaix/index'
            libs:
               primus: 'scripts/libs/mosaix/libs/primus'
         quadrix: 
            index: 'scripts/libs/quadrix/index'

      # here for requirejs amd compatibilities.
      shim: # used to setup modules dependencies.
         jquery_easing:
            deps: ['jquery'], 
            exports: '$'
         jquery_ui:
            deps: ['jquery', 'jquery_easing', 'animate_css'], 
            exports: '$'
         mousewheel:
            deps: ['jquery']
         touchswipe:
            deps: ['jquery']
         scrollbar:
            deps: ['jquery', 'mousewheel']
         namespace:
            deps: ['jquery'], exports: '$'
         animate_css:
            deps: ['jquery']
      
      map:
         jquery_private:
            jquery: 'jquery'
            '*':
               jquery: 'scripts/libs/quadrix/libs/jquery/jquery.private'