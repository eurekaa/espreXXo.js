
jx.test.define 'jarvix.library', ->

   @.describe '.config()', ->
      @.it 'correctly configures libraries', ()->
         jx.test.expect(true).to.be.true
         #jx.test.expect(sample.date.default_pattern).to.equal 'DD-MM-YYYY'