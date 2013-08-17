# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 08/08/13 20.58

'use continuum'

require.config
   baseUrl: '.',
   urlArgs: "v=" +  (new Date()).getTime(), # todo: DISABLE BEFORE GOING TO PRODUCTION!

   paths:
      dom_ready: 'scripts/lib/require.js/dom_ready', # this function fires only when the dom is loaded.
      order: 'scripts/lib/require.js/order', # lets you specify the order in which modules are evaluated.
      text: 'scripts/lib/require.js/text', # enable require.js to load other text files (.html, .css, .xml, ...).
      i18n: 'scripts/lib/require.js/i18n', # allows to load localized resources.

      jquery: 'scripts/lib/jquery/jquery-2.0.3.min',
      twitter_bootstrap: 'scripts/lib/twitter_bootstrap/bootstrap.min'

   shim: # used to setup modules dependencies.
      twitter_bootstrap: ['jquery']


define [
   'dom_ready!',
   'jquery',
   'scripts/modules/utils',
   'scripts/modules/menu'
], (dom, jQuery, utils, menu)->

   # load styles
   utils.load_styles ['styles/eurekaa.css', 'styles/fonts.css'], _()

   # start the menu plugin.
   menu '#navigator'