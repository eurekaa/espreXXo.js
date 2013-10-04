# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: mosaix
# Created: 25/09/13 19.30

# setup using requirejs with amd modules instead of node loader.
requirejs = require 'requirejs'
config = requirejs 'configs/require' 
config.nodeRequire = require
requirejs.config config
# load dependencies.
try
   requirejs [
      'confix'
      'jarvix'
      'http'
      'primus'
      'primus-responder'
      'primus-emitter'
      'primus-multiplex'
      'primus-rooms'
      'scripts/libs/mosaix/modules/mongodb'
   ], (cX, jX, http, primus, responder, emitter, multiplex, rooms, mongodb)->
      
      # create socket server.
      server = http.createServer().listen cX.socket['mosaix'].port, -> console.log 'server listening on port ' + cX.socket['mosaix'].port
      server = new primus server, 
         transformer: cX.socket['mosaix'].driver
         parser: cX.socket['mosaix'].parser
      
      # use socket plugins.
      server.use 'responder', responder
      server.use 'emitter', emitter
      server.use 'multiplex', multiplex
      server.use 'rooms', rooms
      
      # create client library.
      server.save __dirname + '/scripts/libs/mosaix/libs/primus.js' 
      
      # wait for clients connections.
      server.on 'connection', (socket)->
         console.log 'connected'
         socket.on 'request', (packet)->
            console.dir packet
            if packet.password != cX.socket['mosaix'].password
               socket.emit 'failure', 'request is not allowed.'
            else
               console.log 'ok'
               packet.server_signature = true
               socket.emit 'response', packet
               
catch e then console.error e