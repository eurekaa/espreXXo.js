# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: config
# Created: 21/08/13 15.08


### ------ Custom ------- ###



### ------ Edijson.js ------- ###
edijson:
   secret_key: 'dkjfad7f6qrh7r234fda767sdf2j3'
   database:
      host: 'localhost'
      port: '27100'
      username: 'root'
      password: 'r00t!'



### ------ jQuery.js ------- ###
jquery:
   themes:
      primary: 'dark_hive'



### ------ Require.js ------- ###
require_js:
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

      config: 'config'

   shim: # used to setup modules dependencies.
      jquery_ui: deps: ['jquery'], exports: '$'
      twitter_bootstrap: deps: ['jquery']

   map:
      jquery_private:
         jquery: 'jquery'
         '*': jquery: 'scripts/lib/jquery/jquery_private'
