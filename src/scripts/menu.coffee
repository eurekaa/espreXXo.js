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
   'animate_css'
], ($, jx, template) ->
   

   # load stylesheets.
   jx.load.stylesheets ['styles/menu.css']


   # create widget.
   self = undefined
   $.widget 'widgets.menu',


      options:
         localizer: undefined
         breadcrumber: undefined
         slider: undefined


      _create: ->
         # preserve context.
         self = @

         # add class to container.
         self.element.addClass 'menu'

         # localize template and insert into widget container.
         self.options.localizer.localize $(template), (err, template)-> 
            if err then throw err
            self.element.html template


      _init: ()->

         # check arguments.
         if not jx.utility.is_defined self.options.localizer then throw 'menu._create: localizer must be defined.'
         if not jx.utility.is_defined self.options.slider then throw 'menu._create: slider must be defined.'

         # bind click events.
         self.element.find('ul li a').on 'click', self._load_page

         # bind locale changer.
         self.options.localizer._on 'localize_begin', self._animate


      _animate: ()->
         $(self.element).filter('li').each (i, item)-> item.animate_css 'bounceInDown', ( 100 * ++i )


      _load_page: ()->

         # require page, localize it and append to container.
         element = $(@)
         page = element.attr 'data-link' 

         # slide in new page
         self.options.slider.load page, 'bounceOutRight', 'bounceInLeft'

         # change menu status.
         self.element.find('li').each (i, item)-> $(item).removeClass 'active'
         element.parent().addClass 'active'

         # change breadcrumb.
         #self.options.breadcrumber.reset(jx.utility.to_capitalized(element.html()))


      _destroy: ->
         self.element.removeClass 'menu'