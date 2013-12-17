# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: object
# Created: 01/09/13 21.54

jarvix_module = if typeof window != 'undefined' then window['jarvix_memory'].module else global['jarvix_memory'].module
jarvix_module.define 'jarvix/object', ['underscore'], (_)->

   create: Object.create
   
   get_properties: Object.getOwnProperties
   
   freeze: (object)-> Object.freeze object


   ###*
   @summary Retrieve all the names of the object's properties.  
   @param {object} object - object to be analized.   
   @return {array} an array with all property names founded.   
   @example .keys({one: 1, two: 2, three: 3}); => ["one", "two", "three"]
   ###
   keys: (object)-> _.keys object


   has: (object, key)-> _.has object, key 
   
   extend: _.extend  