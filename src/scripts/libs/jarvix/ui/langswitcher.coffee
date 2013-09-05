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


   # create widget.
   $.widget 'qX.langswitcher',


      options:
         ready: false
         locale: 'en'


      _create: -> @.main @.element, @.options 


      main: (element, options)->
         self = @

         # save initial locale in session.
         jx.localizer.set_locale options.locale

         # set initial localizer link active.
         element.find('[data-locale=' + options.locale + ']').addClass 'active'

         # bind localizer click event.
         element.find('[data-locale]').on 'click', ->
            link = $(@)
            
            # if active return.
            if link.hasClass 'active' then return
            
            # save new locale.
            jx.localizer.set_locale link.attr 'data-locale'

            # toggle active class.
            element.find('[data-locale]').removeClass 'active'
            link.addClass 'active'
         
         # trigger ready event.
         options.ready = true
         element.trigger 'ready'


