# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: localizer
# Created: 03/09/13 11.34

define ['jquery', 'async',
        'scripts/libs/jarvix/modules/service'
        'scripts/libs/jarvix/modules/utility'
], ($, async, service, utility)->


   get_locale: ()-> sessionStorage.getItem 'locale'


   set_locale: (locale)->
      # save new locale in session.
      sessionStorage.setItem 'locale', locale
      
      # trigger localize event (must be handled by widgets)
      $(window).trigger 'localize'


   ###*
      @summary Localizes all elements inside @element.
      @param {DOMelement} element - element to be localized.
      @param {string} [locale] - locale to be used.
      @param {function} callback - the function to be invoked after execution.
      @description
      This function asynchronously finds all tags inside @element which have a 'data-lang' attribute  
      and localizes them using the appropriate locale (@locale if provided, global locale otherwise).  
      >*data-lang tag attribute must specify the JavaScript file path (without extension) and property of the label to use, in this form:*  
      ><tag data-lang='path/to/file#path.to.property'></tag>  
      To set locale globally use *localizer.set_locale(locale);*
      @todo: parallelize
      @todo: fallback when labels file is not found
      @example
      .localize($('body'), function(){...});
      .localize($('div.english'), 'en', function(){...}); // useful to localize different parts with differen locales.
   ###
   localize: (element, locale, callback)->
      self = @

      # locale is optional.
      if utility.is_function locale then callback = locale; locale = undefined;

      # check arguments.
      if not utility.is_defined callback then throw new Error 'a callback function must be defined.'

      # check arguments.
      if not element instanceof jQuery then callback 'element must be a jQuery object.'

      # find localizable elements and return if none is found.
      localizables = element.find '[data-label], [label]'
      if localizables.length == 0 then localizables = element.filter '[data-label], [label]' 
      if localizables.length == 0 then return callback null, element

      # find each tag with data-lang attribute and localize it.
      async.each localizables, (node, next)->
         node = $(node)
         label = node.attr 'data-label' 
         label = label || node.attr 'label' 
         
         # call translations service.
         service.i18n label, (err, text)->
            if err then next err
            
            # change tag value.
            node.fadeOut()
            node.html text
            node.fadeIn()
            next()

      , (err)-> if err then callback err else callback null, element