# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: espreXXo
# Created: 25/09/13 19.30



# *** BROWSER SIDE SCRIPTING. ***
if typeof window != 'undefined' # is browser.
   
   # set environment type [debug|test|production]
   window.environment = 'debug'
   
   # prepare to import jarvix.
   script = document.createElement 'script'
   script.src = 'scripts/libs/jarvix/index.js'
   
   # handle jarvix ready event.
   script.addEventListener 'ready', (event)->
      try
         # require dependencies.
         jX.require ['jarvix://string'], (string)->
            console.log string
      catch err then console.error err
         

   # append jarvix to dom.
   document.getElementsByTagName('head')[0].appendChild script



# *** SERVER SIDE SCRIPTING. ***
else # is nodejs 
   
   try
      # eventify global object.
      eventify = require 'eventify'
      eventify.enable global
      
      # set runtime type.
      global.environment = 'debug'

      # import jX library.
      require './scripts/libs/jarvix/index'
      
      # on jarvix ready      
      global.on 'jarvix:ready', ->
         jX = global.jX
         
         # load espreXXo dependencies.
         jX.require [
            'sys://mosaix'
            'node://http'
            'node://primus'
            'node://primus-responder'
            'node://primus-emitter'
            'node://primus-multiplex'
            'node://primus-rooms' 
            'mosaix'
            'mosaix://databases/mongodb'
         ], (mY, http, primus, responder, emitter, multiplex, rooms, mX, mongodb)->
            
            # create socket server.
            server = http.createServer().listen mY.sockets['system'].port, -> console.log 'system socket listening on port ' + mY.sockets['system'].port
            server = new primus server, 
               transformer: mY.sockets['system'].driver
               parser: mY.sockets['system'].parser
            
            # use socket plugins.
            server.use 'responder', responder 
            server.use 'emitter', emitter
            server.use 'multiplex', multiplex
            server.use 'rooms', rooms
            
            # create client socket library.
            server.save __dirname + '/scripts/libs/mosaix/libs/primus.js' 
            
            # wait for clients connections.
            server.on 'connection', (socket)->
               console.log 'connected'
               socket.on 'request', (packet)->
                  console.dir packet
                  if packet.password != mY.sockets['system'].password
                     socket.emit 'failure', 'request is not allowed.'
                  else
                     console.log 'ok'
                     packet.server_signature = true
                     socket.emit 'response', packet
   catch err then console.dir err    