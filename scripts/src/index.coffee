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
      # require.js plugins.
      dom_ready: 'lib/require.js/dom_ready', # dom_ready() function for require.js
      #order: 'lib/require.js/order' # make it possible to load dependencies and evaluate them in the needed order (automatically required). PS: use shim config instead.
      # other libs.
      jquery: 'lib/jquery/jquery-2.0.3.min',
      twitter_bootstrap: 'lib/twitter_bootstrap/bootstrap.min'

   # used to setup modules dependencies.
   shim:
      twitter_bootstrap: ['jquery']


define ['jquery', 'dom_ready', 'twitter_bootstrap', 'modules/utils'],
(jQuery, dom_ready, twitter_bootstrap, utils)->

   # load styles
   utils.load_styles [
      # twitter bootstrap.
      'styles/twitter_bootstrap/bootstrap.css',
      # twitter bootstrap customizations.
      'styles/bootstrap_custom.css',
      # eurekaa.
      'styles/eurekaa.css'
   ], _()

   dom_ready ()->

      # twitter bootstrap main dom styling.
      $('body').addClass 'container'
      $('img').addClass 'img-responsive'
      $('table').addClass 'table table-striped table-hover table-bordered'

