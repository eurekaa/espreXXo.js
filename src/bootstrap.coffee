# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: bootstrap
# Created: 05/09/13 14.17


# define bootstrap.
define 'bootstrap', ['config/index'], (config)->

   # setup require.js
   require.config config.require

   # require nowavailable libraries.
   require ['dom_ready', 'jquery', 'jarvix'], (dom_ready, $, jX)->

      # load main stylesheets.
      jX.load.stylesheets [
         'styles/libs/jquery/themes/eurekaa/jquery-ui-1.10.3.custom.css'
         'styles/libs/animate.css'
      ]

      # set initial locale.
      jX.localizer.set_locale 'it'

      # when the dom is fully loaded.
      dom_ready (dom)->
         
         # parse body to create widgets.
         jX.parser.create_widgets $('body'), (err)->
            if err then console.error err

###
require.onError = (required_type, required_modules)->
   console.error required_type
   console.error required_modules   
###   