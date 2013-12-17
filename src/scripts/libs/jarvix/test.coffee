# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 16/10/13 18.06


jarvix_memory = if typeof window != 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
jarvix_path = jarvix_memory.path
jarvix_module = jarvix_memory.module


jarvix_module.config
   paths:
      chai: jarvix_path + 'libs/chai'
      #mocha: jarvix_path + 'libs/mocha'
   use: 
      mocha: attach: 'describe'

jarvix_module.define 'jarvix/test', [
   'chai'
   'mocha'
], (chai, mocha)->


   define: (name, dependencies, callback)->
      self = @
      
      # wrap define in a pending test and callback dependencies when done.
      describe 'jarvix/test', ->
         it name + ' loading dependencies', (done)->
            jarvix_module.require dependencies, (dependencies)->
               true.should.equal true
               self.describe name, ->
                  callback dependencies
                  done()

   before: (callback)-> before callback
   before_each: (callback)-> before_each callback
   after: (callback)-> after callback
   after_each: (callback)-> after_each callback
   
   describe: (name, callback)-> describe name, callback

   should: chai.should()
   
   expect: chai.expect
   
   run: (tests, callback)->
      
      if typeof window is 'undefined'
         test = new mocha
            ui: 'bdd'
            reporter: 'spec'
         
         jarvix_module.resolve_paths tests, (err, tests)->
            if err then return calback err
            test.addFile file for file in tests 
            test.run callback