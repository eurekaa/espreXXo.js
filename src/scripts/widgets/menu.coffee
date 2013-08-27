# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59

'use continuum'


define [
   'jquery_ui'
   'jarvix'
   'text!pages/menu.html!strip'
], ($, jx, template) ->
   

   # load stylesheets.
   jx.load.stylesheets ['styles/menu.css']
   
   #context   
   self = null
   
   # create widget.
   $.widget 'widgets.menu',


      options:
         target: null
         breadcrumbs: null


      _create: ->         
         # save context for using after async calls.
         self = @
         
         # add class to container.
         @.element.addClass 'menu'
         
         # insert template and localize it.
         @.element.html $(template)
         @._change_locale jx.i18n.get_locale()
         
         # bind click events.
         @.element.find('ul li a').on 'click', self._load_page
         @.element.find('#locale a').on 'click', ->
            locale = $(@).attr 'data-locale'
            self._change_locale locale


      _change_locale: (locale)->
         jx.i18n.set_locale = locale
         require ['langs/' + locale + '/menu'], (i18n)->
            $(self.element).find('li').each (i, item) ->
               i++
               label = $(item).find('a').attr('data-i18n').split('/')
               label = label.pop()
               $(item).delay(150 * i).animate { top: -120 }, duration: 'fast', easing: 'easeInElastic', complete: ->
                  $(item).find('a').html i18n[label]
                  $(item).delay(100 * i).animate { top: 0 }, duration: 'fast', easing: 'easeOutElastic'

                  
                  


      _load_page: ->
         element = $(@);

         # require page, localize it and append to container.
         link = element.attr 'data-link'
         page = null; require ['text!pages/' + link + '!strip'], __(page)
         jx.i18n.localize page, __(page)
         self.options.target.html page

         # change menu status.
         self.element.parent().parent().find('li').each (i, item)-> $(item).removeClass 'active'
         element.parent().addClass 'active'

         # change breadcrumb.
         self.options.breadcrumbs.html(jx.utility.to_capitalized(element.html()))


      _destroy: ->