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
define ['jquery_ui', 'jarvix', 'mosaix', 'quadrix'], ($, jX, mX, qX) ->

   # load stylesheets.
   mX.load.stylesheets ['styles/langswitcher.css']
   
   # create widget.
   qX.widget.define 'qX.langswitcher',
   
      options:
         ready: false
         locale: 'en-uk'
         class: 'langswitcher'


      _create: -> @.main @.element, @.options 


      main: (element, options)->         
         self = @
         
         # render element.
         self.element.addClass self.options.class
         html = ''
         datalist = element.find 'datalist option'
         html = '<ul>'
         jX.list.each datalist, (option, i)->
            
            # save initial locale (defined in datalist option with class 'active').
            if option.className == 'active' then console.log option.value; qX.localizer.set_locale option.value
            html += '<li class="' + (option.className || '') + '">'
            html += '<a data-label="' + option.label + '" data-locale="' + option.value + '"></a>'
            html += '</li>'
         html += '</ul>'
         element.html html
         
         # localize element.
         self.localize();

         # bind localizer click event.
         element.find('[data-locale]').on 'click', ->
            link = $(@)
            
            # if active return.
            if link.hasClass 'active' then return
            
            # save new locale.
            qX.localizer.set_locale link.attr 'data-locale'

            # toggle active class.
            element.find('[data-locale]').removeClass 'active'
            link.addClass 'active'
         
         # trigger ready event.
         options.ready = true
         element.trigger 'ready'


      localize: ()-> qX.localizer.localize @.element, ->
