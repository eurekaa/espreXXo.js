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

# define test module.
jarvix_module.define 'jarvix/test', 
   server: ['node://chai', 'node://mocha']
   client: ['chai', 'mocha']
, (chai, mocha_node)->

   define: (name, dependencies, callback)->
      self = @
      
      # wrap define in a pending test and callback dependencies when done.
      describe 'jarvix/test', ->
         
         it name + ' loading dependencies', (done)->
            jarvix_module.require dependencies, (dependencies)->
               true.should.equal true
               self.describe name, ->
                  if callback then callback dependencies
                  done()

   before: (callback)-> before callback
   before_each: (callback)-> before_each callback
   after: (callback)-> after callback
   after_each: (callback)-> after_each callback
   describe: (name, callback)-> describe name, callback
   it: (name, callback)-> it name, callback

   should: chai.should()
   
   expect: chai.expect
   
   run: (tests, callback)->
      
      if typeof window isnt 'undefined' # is browser.
         
         # add mocha css.
         link = document.createElement 'link'
         link.type = 'text/css'
         link.rel = 'stylesheet'
         link.href = 'http://cdnjs.cloudflare.com/ajax/libs/mocha/1.13.0/mocha.css'
         document.getElementsByTagName('head')[0].appendChild link
         
         # setup test runner.
         mocha.setup 'bdd'
         
         # require tests.
         jarvix_module.require tests, ->

            # run tests.
            mocha.checkLeaks()
            mocha.globals ['jx', 'jX', 'jarvix']
            mocha.run()
      
      else # is nodejs
         test = new mocha_node
            ui: 'bdd'
            reporter: 'spec'
         
         jarvix_module.resolve_paths tests, (err, tests)->
            if err then return callback err
            test.addFile file for file in tests 
            test.run callback