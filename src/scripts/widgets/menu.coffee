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
         breadcrumber: undefined
         slider: undefined


      _create: ->
         # preserve context.
         self = @

         # check arguments.
         if not jx.utility.is_defined self.options.slider then throw 'menu._init: slider must be defined.'

         # add class to container.
         self.element.addClass 'menu'

         # localize menu.
         self.element.find('a[data-lang]').each (i, item)->
            item = $(item)
            localizer.localize item, (err, localized)-> 
               if err then throw err
               item.html(localized.html())

         self._animate()
         
         # bind click events.            
         self.element.find('a[data-link]').on 'click', self._load_page

         # bind locale changer.
         $(window).on 'localize', self._animate


      _animate: ()->
         $(self.element).find('li').each (i, item)-> $(item).animate_css 'bounceInDown', ( 100 * ++i )


      _load_page: ()->

         # require page, localize it and append to container.
         element = $(@)
         page = element.attr 'data-link'

         # slide in new page
         self.options.slider.slide page

         # change menu status.
         self.element.find('li').each (i, item)-> $(item).removeClass 'active'
         element.parent().addClass 'active'

         # change breadcrumb.
         #self.options.breadcrumber.reset(jx.utility.to_capitalized(element.html()))


      _destroy: ->
         self.element.removeClass 'menu'