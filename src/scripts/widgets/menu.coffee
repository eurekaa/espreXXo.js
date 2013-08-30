# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


define [
   'jquery_ui'
   'jarvix'
   'animate_css'
], ($, jx) ->


   # load stylesheets.
   jx.load.stylesheets ['styles/menu.css']


   # create widget.
   self = undefined
   $.widget 'widgets.menu',


      options:
         class: 'menu'
         localizer: undefined
         breadcrumber: undefined
         slider: undefined


      _create: ->
         # preserve context.
         self = @

         # check arguments.
         if not jx.utility.is_defined self.options.localizer then throw 'localizer must be defined.'
         if not jx.utility.is_defined self.options.slider then throw 'slider must be defined.'

         # add class to container.
         self.element.addClass self.options.class 

         # init menu
         self._localize()

         # bind click events.
         self.element.find('a[data-link]').on 'click', self._load_page

         # bind localization event.
         $(window).on 'localize', self._localize


      _localize: ()->
         
         # localize menu.
         self.element.find('li').each (i, item)->
            item = $(item)
            item.animate_css 'bounceInDown', (100 * ++i)
            self.options.localizer.localize item, -> 
         
         # localize current slide.
         page = self.element.find('.active a').attr('data-link').replace '.html', ''
         require ['text!pages/' + page + '.html!strip'], (page)->
            self.options.localizer.localize $(page), (err, page)->
               self.options.slider.slide page, 'bounceOutDown', 'bounceInDown', ->


      _load_page: ()->
         
         element = $(@)
         
         # if active return.
         if element.parent().hasClass 'active' then return

         # destroy plugin on current page if present.
         widget = element.parent().parent().find('.active a').attr 'data-widget'
         if not jx.utility.is_undefined widget
            widget = $('body').data 'widgets-' + widget
            widget.destroy()

         # slide in new page.
         page = element.attr('data-link').replace '.html', ''
         require ['text!pages/' + page + '.html!strip'], (page)->
            self.options.localizer.localize $(page), (err, page)->
               self.options.slider.slide page, (err, page)->
                  # init new widget if present.
                  widget = element.attr 'data-widget'
                  if widget then require ['scripts/widgets/' + widget], ->
                     eval('$("body").' + widget + '()')

         # change menu status.
         self.element.find('li').each (i, item)-> $(item).removeClass 'active'
         element.parent().addClass 'active'

         # change breadcrumb.
         #if self.options.breadcrumber
         #self.options.breadcrumber.reset(jx.utility.to_capitalized(element.html()))


      _destroy: ->
         self.element.removeClass 'menu'