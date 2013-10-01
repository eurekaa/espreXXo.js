# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: mosaix
# Created: 25/09/13 19.30


# use requirejs with amd format instead of node commonjs loader.
requirejs = require "requirejs" 
requirejs.config nodeRequire: require 

requirejs [
   'config/index'
   'http' 
   'primus'
   'primus-emitter'
   'primus-responder'
   'primus-multiplex'
   'primus-rooms'
], (config, http, primus, emitter, responder, multiplex, rooms)->
   
   
   # create socket server.
   server = http.createServer().listen config.mosaix.port, -> console.log 'server listening on port ' + config.mosaix.port
   server = new primus server, 
      transformer: 'websockets'
      parser: 'JSON'

   # use socket plugins.
   server.use 'emitter', emitter   
   server.use 'responder', responder
   server.use 'multiplex', multiplex
   server.use 'rooms', rooms
   #server.save __dirname + '/primus.js' 
   
   # wait for clients connections.
   server.on 'connection', (client)->
      
      client.on 'request', (packet)->
         console.dir packet
         if packet.secret_key == config.mosaix.secret_key
            client.emit 'failure', 'request is not allowed.'
         else
            packet.server_signature = true
            client.emit 'response', packet
