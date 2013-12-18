# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: espreXXo
# Created: 25/09/13 19.30



# *** BROWSER SIDE SCRIPTING. ***
if typeof window isnt 'undefined' # is browser.
   console.log 'espreXXO'
   # set environment type [debug|test|production]
   window.environment = 'debug'

   jx.test.run ['scripts/libs/jarvix/test/index']




# *** SERVER SIDE SCRIPTING. ***
else # is nodejs 

   # import jX library.
   require('./scripts/libs/jarvix/index').ready 'config/jarvix', (err, jX)->
      
      console.log 'espreXXO'  

      jx.test.run ['scripts/libs/jarvix/test/index']
      
      ###
      # load espreXXo dependencies.
      jX.require [
         'config/mosaix'
         'node://http'
         'node://primus'
         'node://primus-responder'
         'node://primus-emitter'
         'node://primus-multiplex'
         'node://primus-rooms' 
      ], (mY, http, primus, responder, emitter, multiplex, rooms)->
         
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
###