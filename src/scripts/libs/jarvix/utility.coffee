# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: utils
# Created: 22/08/13 17.17


###*
   @description
   A set of utilities.   
   
   @module jarvix/utility
   @requires underscore
###


# get module loader and info from memory.
jarvix_memory = if typeof window isnt 'undefined' then window['jarvix_memory'] else global['jarvix_memory']
jarvix_path = jarvix_memory.path
jarvix_module = jarvix_memory.module

#@todo: document utility module.
jarvix_module.define 'jarvix/utility', ['underscore'], (_)->

   # test object functions.
   is_object: (object)-> _.isObject object
   is_equal: (object, other)-> _.isEqual object, other
   is_empty: (object)-> _.isEmpty object
   is_array: (object)-> _.isArray object
   is_function: (object)-> _.isFunction object
   is_arguments: (object)-> _.isArguments object
   is_string: (object)-> _.isString object
   is_number: (object)-> _.isNumber object
   is_nan: (object)-> _.isNaN object
   is_finite: (object)-> _.isFinite object
   is_boolean: (object)-> _.isBoolean object
   is_regexp: (object)-> _.isRegExp object
   is_null: (object)-> _.isNull object
   is_undefined: (object)-> _.isUndefined object
   is_defined: (object)-> !_.isUndefined object
   is_element: (object)-> _.isElement object
   is_browser: ()-> typeof window isnt 'undefined'
   is_nodejs: ()-> not @.is_browser()

   # string functions.
   to_upper: (string)-> string.toUpperCase()
   to_lower: (string)-> string.toLowerCase()
   to_capitalized: (string)-> @.to_upper(string.charAt 0) + @.to_lower(string.slice 1)


