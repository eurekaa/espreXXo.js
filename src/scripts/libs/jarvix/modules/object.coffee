# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: object
# Created: 01/09/13 21.54

define ['underscore'], (u)->

   ###*
   @summary Retrieve all the names of the object's properties.  
   @param {object} object - object to be analized.   
   @return {array} an array with all property names founded.   
   @example
   .keys({one : 1, two : 2, three : 3}); => ["one", "two", "three"]
###
   keys: (object)-> u.keys object
   
   has: (object, key)-> u.has object, key  