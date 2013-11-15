# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: object
# Created: 01/09/13 21.54

loader = if typeof window != 'undefined' then window.loader else global.loader
loader.define 'jarvix/object', ['underscore'], (u)->

   ###*
   @summary Retrieve all the names of the object's properties.  
   @param {object} object - object to be analized.   
   @return {array} an array with all property names founded.   
   @example
   .keys({one : 1, two : 2, three : 3}); => ["one", "two", "three"]
### 
   
   create: Object.create
   
   get_properties: Object.getOwnProperties
   
   freeze: (object)-> Object.freeze object
   
   keys: (object)-> u.keys object
   
   has: (object, key)-> u.has object, key  