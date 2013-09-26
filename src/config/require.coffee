# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: require
# Created: 05/09/13 12.38

define ->
   
   baseUrl: '.'
   urlArgs: "v=" + (new Date()).getTime() # todo: DISABLE BEFORE GOING TO PRODUCTION!

   paths:
      # config
      config: 'config/index'

      # require.
      dom_ready: 'scripts/libs/require/dom_ready' # this function fires only when the dom is loaded.   
      order: 'scripts/libs/require/order' # lets you specify the order in which modules are evaluated.
      text: 'scripts/libs/require/text' # enable require.js to load other text files (.html, .css, .xml, ...).      
      
      # jquery.
      jquery: 'scripts/libs/quadrix/libs/jquery/jquery'
      jquery_ui: 'scripts/libs/quadrix/libs/jquery/jquery.ui'
      jquery_easing: 'scripts/libs/quadrix/libs/jquery/jquery.easing'
      
      # jquery plugins.
      namespace: 'scripts/libs/quadrix/libs/jquery/jquery.namespace'
      mousewheel: 'scripts/libs/quadrix/libs/jquery/jquery.mousewheel'
      touchswipe: 'scripts/libs/quadrix/libs/jquery/jquery.touchswipe'
      scrollbar: 'scripts/libs/quadrix/libs/jquery/jquery.scrollbar'
      animate_css: 'scripts/libs/quadrix/libs/jquery/jquery.animatecss'  

      # polymer.
      polymer: 'scripts/libs/quadrix/libs/polymer/polymer.min.js'
      platform: 'scripts/libs/quadrix/libs/polymer/platform.min.js'
      
      # jarvix.
      jarvix: 'scripts/libs/jarvix/index'

      # mosaix.
      mosaix: 'scripts/libs/mosaix/index'
      
      # quadrix.
      quadrix: 'scripts/libs/quadrix/index'
      
      # utils libraries.
      underscore: 'scripts/libs/jarvix/libs/underscore'
      async: 'scripts/libs/jarvix/libs/async'


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
      namespace: deps: ['jquery'], exports: '$'
      animate_css:
         deps: ['jquery']
      jarvix:
         deps: ['underscore', 'async']

   map:
      jquery_private:
         jquery: 'jquery'
         '*':
            jquery: 'scripts/libs/quadrix/libs/jquery/jquery.private'