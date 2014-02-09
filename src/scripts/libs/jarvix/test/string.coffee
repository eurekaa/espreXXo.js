# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: string
# Created: 18/12/13 20.11



jx.test.define 'jarvix.string', ->

   @.describe '.contains()', ->
      @.it 'checks if a string is contained', ->
         jx.string.contains('hello world', 'hello').should.equal true
         jx.string.contains('bye bye world', 'hello').should.equal false

   @.describe '.repeat()', ->
      @.it 'repeats string n times', ->
         jx.string.repeat('x').should.equal 'x'
         jx.string.repeat('x', 0).should.equal 'x'
         jx.string.repeat('x', 1).should.equal 'x'
         jx.string.repeat('x', 5).should.equal 'xxxxx'