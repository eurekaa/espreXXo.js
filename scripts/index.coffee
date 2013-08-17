# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 08/08/13 20.58

'use continuum'

require.config
   baseUrl: 'scripts/bin',
   urlArgs: "v=" +  (new Date()).getTime(), # todo: DISABLE BEFORE GOING TO PRODUCTION!

   paths:
      dom_ready: 'lib/require.js/dom_ready', # this function fires only when the dom is loaded.
      order: 'lib/require.js/order', # lets you specify the order in which modules are evaluated.
      text: 'lib/require.js/text', # enable require.js to load other text files (.html, .css, .xml, ...).
      i18n: 'lib/require.js/i18n', # allows to load localized resources.

      jquery: 'lib/jquery/jquery-2.0.3.min',
      #twitter_bootstrap: 'lib/twitter_bootstrap/bootstrap.min'

   shim: # used to setup modules dependencies.
      #twitter_bootstrap: ['jquery']


define [
   'dom_ready!',
   'jquery',
   'modules/utils',
   'modules/menu'
], (dom, jQuery, utils, menu)->

   # load styles
   utils.load_styles ['styles/eurekaa.css'], _()

   # start the menu plugin.
   menu '#navigator'