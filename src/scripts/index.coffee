# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 08/08/13 20.58

'use continuum'


# setup require.js
require.config
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
      animate: 'scripts/libs/jquery/jquery.animatecss'
      
      # utils libraries.
      underscore: 'scripts/libs/underscore'
      async: 'scripts/libs/async'
      jarvix: 'scripts/libs/jarvix/index'

   shim: # used to setup modules dependencies.
      jquery_easing: deps: ['jquery'], exports: '$'
      jquery_ui: deps: ['jquery', 'jquery_easing'], exports: '$'   
      mousewheel: deps: ['jquery']
      touchswipe: deps: ['jquery']
      scrollbar: deps: ['jquery','mousewheel']
      animate: deps: ['jquery']
      jarvix: deps: ['underscore', 'async']

   map:
      jquery_private:
         jquery: 'jquery'
         '*': jquery: 'scripts/libs/jquery/jquery.private'



         
# define main AMD module.
define [
   'dom_ready'
   'jquery_ui'
   'jarvix'
   'scripts/widgets/menu'
   'scrollbar'
], (dom_ready, $, jx)->
  
   try
      
      # load stylesheets.
      jx.load.stylesheets [
         'styles/libs/jquery/themes/dark_hive/jquery-ui-1.10.3.custom.css'
         'styles/libs/jquery/scrollbar/jquery.scrollbar.css'
         'styles/libs/animate.css'
         'styles/eurekaa.css'
         'styles/fonts.css'
      ]
   
      # set initial locale.
      jx.i18n.set_locale 'it' 
      
      # wait for dom to be ready.
      dom_ready (dom)->    
   
         # events:
         # when window is resized.
         $(window).on 'resize', ->
            height = $(window).height()
            $('#layout').css height: height + 'px'

         # create menu.
         $('nav').menu target: $('#pages'), breadcrumbs: $('#breadcrumbs')
         
         # create custom scrollbar.
         height = $(window).height()
         $('#layout').css height: height + 'px'
         $('#layout').scrollbar()

         # load pages.
         $('#pages').filter('[data-page]').each (i, item)->
            page = $(item).attr 'data-page'
            require ['text!pages/' + page + '.html!strip'], (page)->
               jx.i18n.localize $(page), (err, page)->
                  if err then throw err
                  $(item).html $(page)

   catch error
      console.error error
      


