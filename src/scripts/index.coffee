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
   'mosaix'
   'quadrix'
], (jX, mX, qX)->

   # load stylesheets.
   mX.load.stylesheets [
      'styles/eurekaa.css'
      'styles/fonts.css'
   ]
   
   qX.widget.define 'index', qX._widget(),

      console.dir $.fn
      
      options:
         ready: false

      _create: ()->
         @._super()
         console.log 'create index'
         @.main @.element, @.options
         
         
      main: (element, options)->

         # trigger ready event.
         options.ready = true
         element.trigger 'ready'