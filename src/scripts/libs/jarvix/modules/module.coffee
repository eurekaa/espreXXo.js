# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: module
# Created: 04/10/13 19.21


define [], ->

   define: (name, dependencies, module)->

      # check if name is passed.
      if not module then throw new Error 'you must specify a module name'

      if typeof window is not 'undefined' # is browser
         define name, dependencies, module

      else # is nodejs
         # requirejs 4 node doesn't work if a name is passed. 
         define dependencies, module


   require: (dependencies, module)->

      # attention: requirejs 4 node is synchronous when dependencies is a string.
      # do not turn dependencies into an array (if a string) to have it work. 
      return require dependencies, module

