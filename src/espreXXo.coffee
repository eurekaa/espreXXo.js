# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: espreXXo
# Created: 25/09/13 19.30

# define global jX library.
jX = undefined

# *** CLIENT SIDE SCRIPTING. ***
if typeof window != 'undefined' # is browser
   
   # import global jX library.
   script = document.createElement 'script'
   script.src = 'scripts/libs/jarvix/index.js'
   document.getElementsByTagName('head')[0].appendChild script


# *** SERVER SIDE SCRIPTING. ***
else # is nodejs 
   
   # init and configure amd loader.
   requirejs = require 'requirejs'
   
   # requirejs 4 node must be configured the first time it is required.
   config = requirejs 'configs/require'
   config.nodeRequire = require
   requirejs.config config
   
   # import global jX library (requirejs is now wrapped inside jX.module module).
   jX = requirejs 'jarvix'
   #console.log jX

   console.log jX.string.repeat 'ciao ', 5
   
   #console.log global.jarvix
   
   # load espreXXo dependencies.
   jX.module.require [
      'confix'
      'http'
      'primus'
      'primus-responder'
      'primus-emitter'
      'primus-multiplex'
      'primus-rooms'
      'scripts/libs/mosaix/modules/mongodb'
   ], (cX, http, primus, responder, emitter, multiplex, rooms, mongodb)->
      
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
      
      # create client socket library.
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
            