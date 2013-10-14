# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: server
# Created: 24/09/13 0.28

# https://github.com/primus/primus.

jX = require 'jarvix'
jX.module.define 'socket', ['system', 'socket_client'], (sys, primus)->
   
   connect: (callback)->
      server = Primus.connect sys.socket['mosaix'].protocol + '://' + sys.socket['mosaix'].host + ':' + sys.socket['mosaix'].port, {}
      server.on 'open',->console.log 'open'
      callback null, server
   
   
   request: (url, query, callback)->
      
      # open socket connection
      @.connect (err, server)->
         if err then return callback err
         
         # callback error.
         server.on 'failure', (err)-> 
            console.error err
            callback err
         
         # callback retrived resource.
         server.on 'response', (packet)-> 
            console.log packet
            callback null, packet

         # send request to server.
         server.emit 'request',
            username: sys.socket['mosaix'].username
            password: sys.socket['mosaix'].password
            url: url
            query: query