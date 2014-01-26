# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: string
# Created: 18/12/13 20.11



jx.test.define 'test/event', [], ->

   jx.test.describe '.enable()', ->
      jx.test.it 'extends argument with .on() .off() .trigger() functions.', ->
         target = jx.event.enable {}
         jx.test.expect(target).to.have.property 'on'
         jx.test.expect(target).to.have.property 'off'
         jx.test.expect(target).to.have.property 'trigger'