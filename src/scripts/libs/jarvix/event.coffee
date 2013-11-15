# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: event
# Created: 21/10/13 15.34

  
loader = if typeof window != 'undefined' then window.loader else global.loader
loader.define 'jarvix/event', ['eventify'], (eventify)->

   eventify: Eventify.enable
   on: Eventify.on
   off: Eventify.off
   trigger: Eventify.trigger  