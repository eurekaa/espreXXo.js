# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 16/10/13 18.06


jarvix_memory = if typeof window isnt 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
jarvix_path = jarvix_memory.path
jarvix_module = jarvix_memory.module

# define test module.
jarvix_module.define 'jarvix/test', ['chai', 'jstest', 'underscore'], (chai, test, _)->

   console.log chai
   
   define: (name, dependencies, callback)->
      
      # if dependendecies are not defined manage it as a test.s
      if _.isFunction dependencies
         callback = dependencies
         JS.Test.describe name, callback
         
      # if dependencies are defined manage it as a library hub.
      else jarvix_module.define name, dependencies, callback

   before: (callback)-> before callback
   before_each: (callback)-> before_each callback
   after: (callback)-> after callback
   after_each: (callback)-> after_each callback
   describe: (name, callback)-> JS.Test.describe name, callback
   it: (name, callback)-> it name, callback

   should: chai.should()
   
   expect: chai.expect
   
   run: (tests, callback)->
      self = @
      
      if typeof window isnt 'undefined' # is browser.
         jarvix_module.require tests, (tests)->
            JS.cache = false
            JS.Test.ASSERTION_ERRORS.push chai.AssertionError() 
            JS.Test.autorun()
      
      else # is nodejs
         jarvix_module.require tests, (tests)->
            JS.Test.ASSERTION_ERRORS.push chai.AssertionError()
            JS.Test.autorun (runner)->
               runner.setReporter new JS.Test.Reporters.Spec()
               runner.addReporter JS.Test.Reporters.ExitStatus()
               runner.addReporter JS.Test.Reporters.Error()
               