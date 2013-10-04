# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: server
# Created: 24/09/13 0.28

# https://github.com/primus/primus.

define ['jarvix', 'confix', 'socket_client'], (jX, cX, primus)->
   
   connect: (callback)->
      server = Primus.connect cX.socket['mosaix'].protocol + '://' + cX.socket['mosaix'].host + ':' + cX.socket['mosaix'].port, {}
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
            username: cX.socket['mosaix'].username
            password: cX.socket['mosaix'].password
            url: url
            query: query