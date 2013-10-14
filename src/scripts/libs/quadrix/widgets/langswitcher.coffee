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


jX = require 'jarvix'
jX.module.define 'langswitcher', [
   'jquery_ui'
   'mosaix'
   'quadrix'
], ($, mX, qX) ->
   
   # create widget.
   qX.widget.define 'qX.langswitcher',
   
      options:
         stylesheet: 'styles/langswitcher.css'
         class: 'langswitcher'
         locale: 'en-uk'
      
      
      _render: (callback)->
         html = '<ul>'
         jX.list.each @.options.dataset, (row, i)->
            if row.active == true then qX.localizer.set_locale row.data
            html += '<li class="' + (if row.active == true then 'active' else '') + '">'
            html += '<a data-label="' + row.id + '" data-locale="' + row.data + '"></a>'
            html += '</li>'
         html += '</ul>'
         @.element.html html

         callback null
      
      
      _ready: (callback)->
         self = @
         
         # bind localizer click event.
         self.element.find('[data-locale]').on 'click', ->
            link = $(@)
            if link.hasClass 'active' then return
            else self.change link.attr 'data-locale'
         
         callback null
      
      
      change: (locale)->
         
         # save new locale (will trigger window 'localize' event.
         qX.localizer.set_locale locale
         
         # toggle active class.
         @.element.find('[data-locale]').removeClass 'active'
         @.element.find('[data-locale="' + locale + '"]').addClass 'active'
         