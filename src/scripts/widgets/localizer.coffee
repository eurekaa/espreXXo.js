# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59

###*
   See [jQuery](http://jquery.com/).
   @name jQuery
   @class
   See the jQuery Library  (http://jquery.com/) for full details.  This just
   documents the function and classes that are added to jQuery by this plug-in.
###

###*
   See [jQuery](http://jquery.com/)
   @name fn
   @class
   See the jQuery Library  (http://jquery.com/) for full details.  This just
   documents the function and classes that are added to jQuery by this plug-in.
   @memberOf jQuery
###
define ['jquery_ui', 'jarvix'], ($, jx) ->

   # load stylesheets.
   #jx.load.stylesheets ['styles/menu.css']


   # create widget.
   self = null
   $.widget 'widgets.localizer',


      options:
         locale: 'it'

      _create: -> 
         self = @

      _init: ->
         # setup default locale
         self.set_locale self.options.locale


      set_locale: (locale)-> sessionStorage.setItem('locale', locale)
      get_locale: ()-> sessionStorage.getItem('locale')


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

         # locale argument is optional.
         if jx.utility.is_function locale then callback = locale; locale = undefined;

         # check arguments.
         if not jx.utility.is_function callback then throw 'localizer.localize: callback function must be defined.'
         if not element instanceof jQuery then callback 'element must be a jQuery object.'

         # trigger before_localize
         self._trigger 'localize_begin'

         # find localizable elements and return if none is found.
         localizables = $(element).filter '[data-lang]' 
         if localizables.length == 0 then return callback  null, element

         # find each tag with data-lang attribute and localize it.
         jx.async.each localizables, (node, next)->
            node = $ node

            # find node label file and property.
            lang_file = node.attr 'data-lang'
            lang_file = lang_file.split '#'
            lang_key = lang_file[1]
            lang_file = lang_file[0].replace '.js', ''

            # require appropriate lang file and use label to change tag content.
            locale = locale || self.get_locale()
            require ['langs/' + locale + '/' + lang_file], (lang_file)->
               node.html lang_file[lang_key]
               next()

         ,(err)-> 
            if err then callback err 
            else
               self._trigger 'localize_complete'
               callback null, element

      pippo: -> alert 'pippo'  