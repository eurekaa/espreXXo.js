# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: include
# Created: 05/09/13 12.38


# ATTENTION: do not use jarvix here cause this module has to be loaded before.
define [], ()->
   
   baseUrl: '.'
   urlArgs: "v=" + (new Date()).getTime() # todo: DISABLE BEFORE GOING TO PRODUCTION!

   directories:
      node: '../node_modules/'
      jarvix: 'scripts/libs/jarvix/modules/'
      mosaix: 'scripts/libs/mosaix/modules/'
      quadrix: 'scripts/libs/quadrix/modules/'
      quadrix_ui: 'scripts/libs/quadrix/widgets/'
      sys: 'sys/'

   paths:
      
      # require.
      dom_ready: 'scripts/libs/jarvix/libs/require.domready' # this function fires only when the dom is loaded.   
      order: 'scripts/libs/jarvix/libs/require.order' # lets you specify the order in which modules are evaluated.
      text: 'scripts/libs/jarvix/libs/require.text' # enable require.js to load other text files (.html, .css, .xml, ...).      
      
      # system.
      system: 'sys/index'
      
      # jarvix.
      jarvix: 'scripts/libs/jarvix/index'
      underscore: 'scripts/libs/jarvix/libs/underscore' # utils library.
      async: 'scripts/libs/jarvix/libs/async' # asynchronous workflow management.
      
      # mosaix.
      mosaix: 'scripts/libs/mosaix/index'
      socket_client: 'scripts/libs/mosaix/libs/primus' # real-time socket connections.
   
      # quadrix.
      quadrix: 'scripts/libs/quadrix/index'
      jquery: 'scripts/libs/quadrix/libs/jquery/jquery'
      jquery_ui: 'scripts/libs/quadrix/libs/jquery/jquery.ui'
      jquery_easing: 'scripts/libs/quadrix/libs/jquery/jquery.easing'
      namespace: 'scripts/libs/quadrix/libs/jquery/jquery.namespace'
      mousewheel: 'scripts/libs/quadrix/libs/jquery/jquery.mousewheel'
      touchswipe: 'scripts/libs/quadrix/libs/jquery/jquery.touchswipe'
      scrollbar: 'scripts/libs/quadrix/libs/jquery/jquery.scrollbar'
      animate_css: 'scripts/libs/quadrix/libs/jquery/jquery.animatecss'
   
   
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