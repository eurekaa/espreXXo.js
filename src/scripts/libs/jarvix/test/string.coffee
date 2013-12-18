# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: string
# Created: 18/12/13 20.11



jx.test.define 'test/string', ['underscore', 'jarvix://test/string'], (_)->

   jx.test.describe 'is_valid', ->
      it 'checks if a string is valid', ->
         true.should.equal _.isString('cioa')

   jx.test.describe 'repeat', ->
      it 'repeats string n times', ->
         true.should.equal _.isString('cioa')