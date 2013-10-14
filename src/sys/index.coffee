# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 05/09/13 12.38

jX = require 'jarvix'
jX.module.define 'system', [
   'sys://loader'
   'sys://socket'
   'sys://store'
   'sys://namespaces'
], (loader, socket, store, namespaces)->
   
   loader: loader
   socket: socket
   store: store
   namespaces: namespaces