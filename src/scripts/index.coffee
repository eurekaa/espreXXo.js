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
      dom_ready: 'scripts/lib/require.js/dom_ready' # this function fires only when the dom is loaded.
      order: 'scripts/lib/require.js/order' # lets you specify the order in which modules are evaluated.
      text: 'scripts/lib/require.js/text' # enable require.js to load other text files (.html, .css, .xml, ...).
      #i18n: 'scripts/lib/require.js/i18n' # allows to load localized resources.

      jquery: 'scripts/lib/jquery/jquery-2.0.3'
      jquery_ui: 'scripts/lib/jquery/jquery-ui-1.10.3.custom'  
      jquery_easing: 'scripts/lib/jquery/jquery-easing-1.3' 
      twitter_bootstrap: 'scripts/lib/twitter_bootstrap/bootstrap.min'

      # jquery plugins.
      mousewheel: 'scripts/lib/jquery/jquery.mousewheel'
      touchswipe: 'scripts/lib/jquery/jquery.touchswipe'
      scrollbar: 'scripts/lib/jquery/jquery.scrollbar'
      slider: 'scripts/lib/jquery/jquery.slider'
      
      # utils libraries.
      underscore: 'scripts/lib/underscore'
      async: 'scripts/lib/async'
      jarvix: 'scripts/lib/jarvix/index'

   shim: # used to setup modules dependencies.
      jquery_easing: deps: ['jquery'], exports: '$'
      jquery_ui: deps: ['jquery', 'jquery_easing'], exports: '$'
      twitter_bootstrap: ['jquery']
      mousewheel: ['jquery']
      touchswipe: ['jquery']
      scrollbar: ['jquery','mousewheel']
      slider: ['jquery', 'jquery_easing', 'touchswipe']
      jarvix: deps: ['underscore', 'async']

   map:
      jquery_private:
         jquery: 'jquery'
         '*': jquery: 'scripts/lib/jquery/jquery_private'



         
# define main AMD module.
define [
   'dom_ready'
   'jquery_ui'
   'jarvix'
   'scripts/widgets/menu'
   'scrollbar'
   'slider'
], (dom_ready, $, jx)->
  
   try
      
      # load stylesheets.
      jx.load.stylesheets [
         'styles/lib/jquery/themes/dark_hive/jquery-ui-1.10.3.custom.css'
         'styles/lib/jquery/scrollbar/jquery.scrollbar.css'
         'styles/lib/jquery/slider/jquery.slider.css'
         'styles/lib/jquery/slider/jquery.slider_animate.css'
         'styles/eurekaa.css'
         'styles/fonts.css'
      ]
   
      # set initial locale.
      jx.i18n.set_locale 'it' 
      
      # wait for dom to be ready.
      dom_ready (dom)->    

         # localize entire body.
         jx.i18n.localize $('body'), ->
   
         # events:
         # when window is resized.
         $(window).on 'resize', ->
            height = $(window).height()
            $('#layout').css height: height + 'px'

         # when locale changes.
         $(window).on 'localize', (event, locale)->
            # set new locale.
            jx.i18n.set_locale locale
            # localize all body localizable elements.
            jx.i18n.localize $('body')

         # create menu.
         $('nav').menu target: $('#main'), breadcrumbs: $('#breadcrumbs')
         
         # create custom scrollbar.
         height = $(window).height()
         $('#layout').css height: height + 'px'
         $('#layout').scrollbar()
         
         # create slider.
         

   catch error
      console.error error
      


