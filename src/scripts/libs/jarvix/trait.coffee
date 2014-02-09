# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: trait
# Created: 15/10/13 15.41

jarvix_module = if typeof window isnt 'undefined' then window['jarvix_memory'].module else global['jarvix_memory'].module
jarvix_module.define 'jarvix/trait', ['traits'], (trait)->
   
   define: trait
   
   create: trait.create
   
   compose: trait.compose
   
   resolve: trait.resolve
   
   override: trait.override
   
   required: trait.required
   
   is_equal: trait.eqv
   
   object: trait.object