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
      i18n: 'scripts/lib/require.js/i18n' # allows to load localized resources.

      jquery: 'scripts/lib/jquery/jquery-2.0.3.min'
      jquery_ui: 'scripts/lib/jquery/jquery-ui-1.10.3.custom'
      twitter_bootstrap: 'scripts/lib/twitter_bootstrap/bootstrap.min'

      #jquery plugins
      scrollbars: 'scripts/lib/jquery/jquery.mCustomScrollbar'
      mousewheel: 'scripts/lib/jquery/jquery.mousewheel'

   shim: # used to setup modules dependencies.
      jquery_ui: deps: ['jquery'], exports: '$'
      twitter_bootstrap: ['jquery']
      mousewheel: ['jquery']
      scrollbars: ['jquery','mousewheel']

   map:
      jquery_private:
         jquery: 'jquery'
         '*': jquery: 'scripts/lib/jquery/jquery_private'


# define AMD module.
define [
   'dom_ready'
   'jquery_ui'
   'scripts/modules/utils'
   'scripts/modules/menu'
   'scrollbars'
], (dom_ready, jQuery, utils)->

   $ = jQuery

   # load stylesheets.
   utils.load_styles [
      'styles/lib/jquery/themes/dark_hive/jquery-ui-1.10.3.custom.css'
      'styles/lib/jquery/jquery.mCustomScrollbar.css'
      'styles/eurekaa.css'
      'styles/fonts.css'
   ]

   # wait for dom to be ready.
   dom_ready (dom)->

      # start menu.
      $('#menu').menu()

      # custom scrollbars.
      height = $(window).height()
      $('#layout').css height: height + 'px'
      $('#layout').mCustomScrollbar
         scrollInertia: 500
         mouseWheelPixels: 700
         scrollButtons: enable: true
      $('.mCSB_container').css margin: 0

      $(window).resize ()->
         height = $(window).height()
         $('#layout').css height: height + 'px'
