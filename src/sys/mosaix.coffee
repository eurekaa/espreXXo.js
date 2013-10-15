# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: sockets
# Created: 01/10/13 23.37

jX = require 'jarvix'
jX.module.define 'mosaix', [], ()->

   sockets:
   
      system:
         driver: 'websockets'
         parser: 'JSON'
         protocol: 'http'
         host: 'localhost'
         port: 8080
         username: 'espreXXo'
         password: 'aJHJKHFD932MNFiudf98n3ndfSDFsd3'

   databases:
   
      espreXXo:
         driver: 'mongodb'
         parser: 'JSON'
         name: 'espreXXo'
         protocol: 'http'
         host: 'localhost'
         port: 28017
         username: ''
         password: ''
         identity: '_id'