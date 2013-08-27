# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: array
# Created: 23/08/13 11.08


###*
   @description
   A set of function to work on object or list of objects.     
   This module is strongly based on [underscore](https://github.com/jashkenas/underscore).
   >*Note: Collection functions work on arrays, objects, and array-like objects such as arguments, NodeList and similar.
   >But it works by duck-typing, so avoid passing objects with a numeric length property.*

   @module jarvix/object
   @requires underscore
###
define 'jarvix/object', ['underscore'], (u)->

   ###*
      @author stefano graziato
      @summary Iterates over a list of elements, yielding each in turn to an iterator function.
      @param {(object|array)} list - elements to be iterated.
      @param {function} iterator - function invoked on each element.
      @param {object} [context] - the context to be used.
      @description
      The iterator is bound to the context object, if one is passed.    
      Each invocation of iterator is called with three arguments: (item, index, list).   
      If list is a JavaScript object, iterator's arguments will be (value, key, list).    
      Delegates to the native forEach function if it exists.
      @example
      .each([1, 2, 3], alert); => alerts each number in turn...
      .each({one : 1, two : 2, three : 3}, alert); => alerts each number value in turn...
   ###
   each: (list, iterator, context)-> u.each list, iterator, context

   ###*
      @author stefano graziato
      @summary Produces a new array of values by mapping each value in list through a transformation function (iterator). 
      @param {(object|array)} list - elements to be iterated.
      @param {function} iterator - function invoked on each element.
      @param {object} [context] - the context to be used.
      @returns {array} new array of mapped values.
      @description
      If the native map method exists, it will be used instead.   
      If list is a JavaScript object, iterator's arguments will be (value, key, list).   
      @example
      .map([1, 2, 3], function(item, index){ return item * 3; }); => [3, 6, 9]
      .map({one : 1, two : 2, three : 3}, function(value, key){ return value * 3; }); => [3, 6, 9]
   ###
   map: (list, iterator, context)-> u.map list, iterator, context


   ###*
      @author stefano graziato
      @summary Also known as inject and foldl, reduce boils down a list of values into a single value. 
      @param {(object|array)} list - elements to be iterated.
      @param {function} iterator - function invoked on each element.
      @param {*} memo - initial state of the reduction.
      @param {object} [context] - the context to be used.
      @returns {*} any type but a single value.
      @description
      Memo is the initial state of the reduction, and each successive step of it should be returned by iterator.   
      The iterator is passed four arguments: the memo, then the value and index (or key) of the iteration,    
      and finally a reference to the entire list.
      @example
      var sum = .reduce([1, 2, 3], function(memo, value, index, context){ return memo + value; }, 0); 
      => 6
   ###
   reduce: (list, iterator, memo, context)-> u.reduce list, iterator, memo, context

   ###*
         @author stefano graziato
         @summary The right-associative version of reduce. 
         @param {(object|array)} list - elements to be iterated.
         @param {function} iterator - function invoked on each element.
         @param {*} memo - initial state of the reduction.
         @param {object} [context] - the context to be used.
         @returns {*} any type but a single value.
         @description
         Delegates to the JavaScript 1.8 version of reduceRight, if it exists.    
         Foldr is not as useful in JavaScript as it would be in a language with lazy evaluation.
         @example
         var list = [[0, 1], [2, 3], [4, 5]];
         var flat = _.reduceRight(list, function(a, b) { return a.concat(b); }, []); 
         => [4, 5, 2, 3, 0, 1]
      ###
   reduce_right: (list, iterator, memo, context)-> u.reduceRight list, iterator, memo, context


   ###*
      @author stefano graziato
      @summary Looks through each value in the list, returning the first one that passes a truth test (iterator), or undefined if no value passes the test. 
      @param {(object|array)} list - elements to be iterated.
      @param {function} iterator - function invoked on each element.
      @param {object} [context] - the context to be used.
      @returns {*} any type but a single value.
      @description
      The function returns as soon as it finds an acceptable element, and doesn't traverse the entire list.
      @example
      var even = .find([1, 2, 3, 4, 5, 6], function(num){ return num % 2 == 0; });
      => 2
   ###
   find: (list, iterator, context)-> u.find list, iterator, context


   ###*
      @author stefano graziato
      @summary Looks through each value in the list, returning an array of all the values that pass a truth test (iterator). 
      @param {(object|array)} list - elements to be iterated.
      @param {function} iterator - function invoked on each element.
      @param {object} [context] - the context to be used.
      @returns {array} an array with all values that pass the iterator test.
      @description
      Delegates to the native filter method, if it exists.
      @example
      var evens = .filter([1, 2, 3, 4, 5, 6], function(num){ return num % 2 == 0; });
      => [2, 4, 6]
   ###
   filter: (list, iterator, context)-> u.filter list, iterator, context

   ###*
      @author stefano graziato
      @summary Looks through each value in the list, returning an array of all the values that contain all of the key-value pairs listed in properties. 
      @param {array} list - array of objects to be iterated.
      @param {object} properties - an object with key-values to match the list.
      @returns {array} array of objects that validate the properties query.      
      @example
      .where(listOfPlays, {author: "Shakespeare", year: 1611});
      => [{title: "Cymbeline", author: "Shakespeare", year: 1611},
         {title: "The Tempest", author: "Shakespeare", year: 1611}]
   ###
   where: (list, properties)-> u.where list, properties

   ###*
      @author stefano graziato
      @summary Looks through the list and returns the first value that matches all of the key-value pairs listed in properties. 
      @param {array} list - array of objects to be iterated.
      @param {object} properties - an object with key-values to match the list.
      @returns {object} the first object that validate the properties query.      
      @example
      .findWhere(publicServicePulitzers, {newsroom: "The New York Times"});
      => {year: 1918, newsroom: "The New York Times",
      reason: "For its public service in publishing in full so many official reports..." }
   ###
   find_where: (list, properties)-> u.findWhere list, properties

   ###*
      @author stefano graziato
      @summary Returns the values in list without the elements that the truth test (iterator) passes. 
      @param {(object|array)} list - elements to be iterated.
      @param {function} iterator - function invoked on each element.
      @param {object} [context] - the context to be used.
      @returns {array} an array with all values that pass the iterator test.
      @description
      The opposite of .filter.
      @example
      var odds = .reject([1, 2, 3, 4, 5, 6], function(num){ return num % 2 == 0; });
      => [1, 3, 5]
   ###
   reject: (list, iterator, context)-> u.reject list, iterator, context

   ###*
   @author stefano graziato
   @summary Returns true if all of the values in the list pass the iterator truth test. 
   @param {(object|array)} list - elements to be iterated.
   @param {function} [iterator] - function invoked on each element.
   @param {object} [context] - the context to be used.
   @returns {boolean} returns true if all values in the list pass the iterator test, unless false.
   @description
   Delegates to the native method every, if present.
   @example
   .every([true, 1, null, 'yes'], jarvix.utility.identity);
   => false
   ###
   every: (list, iterator, context)-> u.every list, iterator, context

      
   ###*
   @author stefano graziato
   @summary Returns true if any of the values in the list pass the iterator truth test. 
   @param {(object|array)} list - elements to be iterated.
   @param {function} [iterator] - function invoked on each element.
   @param {object} [context] - the context to be used.
   @returns {boolean} returns true if at least one value in the list pass the iterator test, unless false.
   @description
   Short-circuits and stops traversing the list if a true element is found.   
   Delegates to the native method some, if present.
   @example
   .some([null, 0, true, false]);
   => true
   ###
   some: (list, iterator, context)-> u.some list, iterator, context      