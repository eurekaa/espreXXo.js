# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: trait
# Created: 15/10/13 15.41

loader = if typeof window != 'undefined' then window.loader else global.loader
loader.define 'jarvix/trait', ['traits'], (trait)->
   
   define: trait
   
   create: trait.create
   
   compose: trait.compose
   
   resolve: trait.resolve
   
   override: trait.override
   
   required: trait.required
   
   is_equal: trait.eqv
   
   object: trait.object