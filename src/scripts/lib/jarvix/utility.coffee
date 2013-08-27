# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: utils
# Created: 22/08/13 17.17


'use continuum'

define ['underscore'], (u)->

   # test object functions.
   is_object: (object)-> u.isObject object
   is_equal: (object, other)-> u.isEqual object, other
   is_empty: (object)-> u.isEmpty object
   is_array: (object)-> u.isArray object
   is_function: (object)-> u.isFunction object
   is_arguments: (object)-> u.isArguments object
   is_string: (object)-> u.isString object
   is_number: (object)-> u.isNumber object
   is_nan: (object)-> u.isNaN object
   is_finite: (object)-> u.isFinite object
   is_boolean: (object)-> u.isBoolean object
   is_regexp: (object)-> u.isRegExp object
   is_null: (object)-> u.isNull object
   is_undefined: (object)-> u.isUndefined object
   is_defined: (object)-> not u.isUndefined object
   is_element: (object)-> u.isElement object

   # string functions.
   to_upper: (string)-> string.toUpperCase()
   to_lower: (string)-> string.toLowerCase()
   to_capitalized: (string)-> @.to_upper(string.charAt 0) + @.to_lower(string.slice 1)

   ###*
      @author stefano graziato
      @summary reapeat a string several times.
      @param {string} string - string to be repeated.
      @param {number} [times=1] - number of times the string has to be repeated.
      @returns {string} string - the string repeated.
      @example
      .repeat('a', 5); => 'aaaaa'
   *###
   repeat: (string, times)->
      times = 1 if @.is_undefined times or times < 1
      new Array(times + 1).join string
