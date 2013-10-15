# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: espreXXo
# Created: 25/09/13 19.30

# *** BROWSER SIDE SCRIPTING. ***
if typeof window != 'undefined' # is browser

   # configure requirejs.
   require ['sys/jarvix'], (jY)->
      require.config jY
      require.onError = (err)-> 
         #console.dir err
         throw err
      

      # import jarvix library and make it global 4 the browser.
      # (in nodejs you have to require it).
      require ['jarvix'], (jarvix)->
         window.jX = jX = jarvix
         
         # require dependencies.
         jX.module.require [
            'dom_ready' 
            'mosaix'
            'quadrix'
         ], (dom_ready, mX, qX)->
            
            # load main stylesheets.
            mX.load.stylesheets [
               'styles/libs/jquery/themes/eurekaa/jquery-ui-1.10.3.custom.css'
               'styles/libs/animate.css'
            ]
   
            # when the dom is fully loaded.
            dom_ready (dom)->
   
               # parse body to create widgets.
               qX.parser.parse $('body'), (err)->
                  if err then console.error err




# *** SERVER SIDE SCRIPTING. ***
else # is nodejs 
   
   # init and configure requirejs.
   requirejs = require 'requirejs'
   jY = requirejs 'sys/jarvix'
   jY.nodeRequire = require
   jY.urlArgs = '' # requirejs 4 node doesn't support urlArgs.
   requirejs.config jY
   
   # import jX library.
   jX = requirejs 'jarvix'
    
   # load espreXXo dependencies.
   jX.require [
      'sys://mosaix'
      'http'
      'primus'
      'primus-responder'
      'primus-emitter'
      'primus-multiplex'
      'primus-rooms'
      'mosaix://databases/mongodb'
   ], (mY, http, primus, responder, emitter, multiplex, rooms, mongodb)->
      
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
            