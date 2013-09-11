# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 08/08/13 20.58


# define main AMD module.
define [
   'jarvix'
   'quadrix'
], (jX, qX)->

   
   # load stylesheets.
   jX.load.stylesheets [
      'styles/libs/jquery/scrollbar/jquery.scrollbar.css'
      'styles/eurekaa.css'
      'styles/fonts.css'
   ]

   qX.widget.define 'eK.index',
      
      _create: ->
         
         try
           
         catch err
            console.error err
            console.error err.stack