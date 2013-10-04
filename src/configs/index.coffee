# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 05/09/13 12.38

define [
   'jarvix'
   'configs/require'
   'configs/socket'
   'configs/store'
   'configs/namespaces'
], (jX, require, socket, store, namespaces)->
   
   require: require
   socket: socket 
   store: store 
   namespaces: namespaces