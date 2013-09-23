# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 08/08/13 20.58


# define main AMD module.
define [
   'jquery_ui'
   'jarvix'
   'mosaix'
   'quadrix'
], ($, jX, mX, qX)->

   # load stylesheets.
   mX.load.stylesheets [
      'styles/eurekaa.css'
      'styles/fonts.css'
   ]
   
   qX.widget.define 'index',

      options: {}
      