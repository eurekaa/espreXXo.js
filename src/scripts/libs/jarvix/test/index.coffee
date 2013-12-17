# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: structural
# Created: 16/10/13 22.26


#@todo: riconoscere la presenza di jarvix, in caso contrario caricarla manualmente
# (nel caso venga lanciato il test da console).

jx.test.define 'test/string', ['underscore'], (_)->
   
   jx.test.describe 'is_valid', ->
      it 'checks if a string is valid', ->
         true.should.equal _.isString('cioa')

   jx.test.describe 'repeat', ->
      it 'repeats string n times', ->
         true.should.equal _.isString('cioa')  