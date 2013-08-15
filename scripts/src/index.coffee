# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 08/08/13 20.58

'use continuum'

require.config
   baseUrl: 'scripts/bin'
   paths:
      jquery: 'lib/jquery/jquery-2.0.3.min',
      dom_ready: 'lib/require/dom_ready',
      twitter_bootstrap: 'lib/twitter_bootstrap/bootstrap.min'


define ['jquery', 'dom_ready', 'twitter_bootstrap', 'modules/utils'],
(jQuery, dom_ready, twitter_boostrap, utils)->

   dom_ready ()->

      $ = jQuery

      # load styles
      utils.load_styles [
         # twitter bootstrap.
         'styles/twitter_bootstrap/bootstrap.min.css',
         'styles/twitter_bootstrap/bootstrap-responsive.min.css',
         # twitter bootstrap customizations.
         'styles/bootstrap_custom.css',
         # eurekaa.
         'styles/eurekaa.css'
      ], _()

      # twitter bootstrap main dom styling.
      $('body').addClass 'container'
      $('img').addClass 'img-responsive'
      $('table').addClass 'table table-striped table-hover table-bordered'

