# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: espreXXo
# Created: 25/09/13 19.30



# *** BROWSER SIDE SCRIPTING. ***
if typeof window isnt 'undefined' # is browser.
   console.log 'test'
   # set environment type [debug|test|production]
   window.environment = 'debug'

   jX.test.run ['scripts/libs/jarvix/test/index']




# *** SERVER SIDE SCRIPTING. ***
else # is nodejs 

   # import jX library.
   require('../scripts/libs/jarvix/index').ready 'config/jarvix', (err, jX)->
      if err then return console.error err
      
      jX.test.run ['scripts/libs/jarvix/test/index']