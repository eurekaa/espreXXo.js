# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: string
# Created: 02/09/13 0.25

jX = require 'jarvix'
console.log jX


jX.module.define 'string', [], ->

   ###*
      @summary reapeat a string several times.
      @param {string} string - string to be repeated.
      @param {number} [times=1] - number of times the string has to be repeated.
      @returns {string} string - the string repeated.
      @example
      .repeat('a', 5); => 'aaaaa'
   *###
   repeat: (string, times)->
      if not times or times < 1 then times = 1
      new Array(times + 1).join string

   starts_with: (string, token)-> new String(string).slice(0, token.length) == token

   ends_with: (string, token)-> new String(string).slice(-token.length) == token

   
   contains: (string, token)-> string.indexOf token != -1
     