# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: server
# Created: 24/09/13 0.28

# https://github.com/primus/primus.


define ['jarvix', 'config', 'socket'], (jX, config, Primus)->
   
   _connect: (callback)->
      server = Primus.connect config.mosaix.host + ':' + config.mosaix.port, {}
      server.on 'open', ->
         console.log 'open'
      callback null, server
   
   
   request: (url, query, callback)->
      
      # open socket connection
      @._connect (err, server)->
         if err then return callback err
         
         # callback retrived resource.
         server.on 'response', (packet)->
            console.log packet
            callback null, packet
            
         server.on 'failure', (error)->
            callback error
         
         # send request to server.
         server.emit 'request',
            secret_key: config.mosaix.secret_key
            url: url
            query: query
         
         
   