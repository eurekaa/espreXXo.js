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
   'animate'
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
               item = $(item)
               label = item.find('a').attr('data-lang').split('#')[1]
               $(item).animate_css 'bounceInDown', (100 * i), ->
                  $(item).find('a').html i18n[label]   



      _load_page: ->
         element = $(@)

         # require page, localize it and append to container.
         link = element.attr 'data-link'
         require ['text!pages/' + link + '.html!strip'], (page)->            
            jx.i18n.localize $(page), (err, page)->
               self.options.target.animate_css 'bounceOutRight', ()->
                  self.options.target.html $(page)
                  self.options.target.animate_css 'bounceInLeft', ()->
                  

               # change menu status.
               self.element.parent().parent().find('li').each (i, item)-> $(item).removeClass 'active'
               element.parent().addClass 'active'

               # change breadcrumb.
               self.options.breadcrumbs.html(jx.utility.to_capitalized(element.html()))


      _destroy: ->