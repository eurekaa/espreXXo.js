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
      # require.
      dom_ready: 'scripts/libs/require/dom_ready' # this function fires only when the dom is loaded.   
      order: 'scripts/libs/require/order' # lets you specify the order in which modules are evaluated.
      text: 'scripts/libs/require/text' # enable require.js to load other text files (.html, .css, .xml, ...).      
      
      # jquery.
      jquery: 'scripts/libs/jquery/jquery'
      jquery_ui: 'scripts/libs/jquery/jquery.ui'
      jquery_easing: 'scripts/libs/jquery/jquery.easing'
      
      # jquery plugins.
      mousewheel: 'scripts/libs/jquery/jquery.mousewheel'
      touchswipe: 'scripts/libs/jquery/jquery.touchswipe'
      scrollbar: 'scripts/libs/jquery/jquery.scrollbar'
      animate_css: 'scripts/libs/jquery/jquery.animatecss'
      
      # jarvix.
      jarvix: 'scripts/libs/jarvix/index'
      
      # utils libraries.
      underscore: 'scripts/libs/utility/underscore'
      async: 'scripts/libs/utility/async'


   shim: # used to setup modules dependencies.
      jquery_easing:
         deps: ['jquery'], 
         exports: '$'
      jquery_ui:
         deps: ['jquery', 'jquery_easing'], 
         exports: '$'
      mousewheel:
         deps: ['jquery']
      touchswipe:
         deps: ['jquery']
      scrollbar:
         deps: ['jquery', 'mousewheel']
      animate_css:
         deps: ['jquery']
      jarvix:
         deps: ['underscore', 'async']

   map:
      jquery_private:
         jquery: 'jquery'
         '*':
            jquery: 'scripts/libs/jquery/jquery.private'