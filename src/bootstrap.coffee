# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: bootstrap
# Created: 05/09/13 14.17


# define bootstrap.
define ['configs/require'], (config)->

   # setup require.js
   require.config config

   # require libraries.
   require [
      'dom_ready'
      'jarvix'
      'mosaix'
      'quadrix'
   ], (dom_ready, jX, mX, qX)->

      # load main stylesheets.
      mX.load.stylesheets [
         'styles/libs/jquery/themes/eurekaa/jquery-ui-1.10.3.custom.css'
         'styles/libs/animate.css'
      ]

      # when the dom is fully loaded.
      dom_ready (dom)->
        
         # parse body to create widgets
         qX.parser.parse $('body'), (err)->
            if err then console.error err


require.onError = (required_type, required_modules)->
   console.error required_type
   console.error required_modules   