# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: array
# Created: 20/10/13 4.46

loader = if typeof window != 'undefined' then window.loader else global.loader
loader.define 'jarvix/array', ['underscore'], (u)->
   
   intersection: u.intersection