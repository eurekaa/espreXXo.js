# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: structural
# Created: 16/10/13 22.26


jX = require 'jarvix'
jX.test.define 'structural', [], ->
   
   jX.test.describe 'traits', ->
      
      jX.test.should(5).have.type 'number'
      