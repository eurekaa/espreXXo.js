# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: espreXXo
# Created: 25/09/13 19.30



# *** BROWSER SIDE SCRIPTING. ***
if typeof window isnt 'undefined' # is browser.
   alert 'test'
   # set environment type [debug|test|production]
   window.environment = 'debug'  
   jx.config.load module: base_path: '../'

   jx.test.run ['../scripts/libs/jarvix/test/index']




# *** SERVER SIDE SCRIPTING. ***
else # is nodejs 

   # import jX library.
   require('../scripts/libs/jarvix/index').ready 'config/jarvix', (err, jx)->
      if err then return console.error err
      
      jx.test.run ['scripts/libs/jarvix/test/index']