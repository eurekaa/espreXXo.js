# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: store
# Created: 02/10/13 0.30

define [
   'confix'
   'jarvix'
], (cX, jX)->
   
   connect: (store_name, callback)->
      
      # retrieve store configuration.
      driver = jX.load cX.store[store_name].driver
      driver.connect callback 
      
      