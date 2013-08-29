# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 08/08/13 20.58


# setup require.js
require.config
   baseUrl: '.'
   urlArgs: "v=" + (new Date()).getTime() # todo: DISABLE BEFORE GOING TO PRODUCTION!

   paths:
      # require.
      dom_ready: 'scripts/libs/require/dom_ready' # this function fires only when the dom is loaded.   
      order: 'scripts/libs/require/order' # lets you specify the order in which modules are evaluated.
      text: 'scripts/libs/require/text' # enable require.js to load other text files (.html, .css, .xml, ...).      

      # jquery.
      jquery: 'scripts/libs/jquery/jquery'
      jquery_ui: 'scripts/libs/jquery/jquery.ui'  
      jquery_easing: 'scripts/libs/jquery/jquery.easing' 

      # jquery plugins.
      mousewheel: 'scripts/libs/jquery/jquery.mousewheel'
      touchswipe: 'scripts/libs/jquery/jquery.touchswipe'
      scrollbar: 'scripts/libs/jquery/jquery.scrollbar'
      animate_css: 'scripts/libs/jquery/jquery.animatecss'
      
      # utils libraries.
      underscore: 'scripts/libs/utility/underscore'
      async: 'scripts/libs/utility/async'
      jarvix: 'scripts/libs/jarvix/index'

   shim: # used to setup modules dependencies.
      jquery_easing: deps: ['jquery'], exports: '$'
      jquery_ui: deps: ['jquery', 'jquery_easing'], exports: '$'   
      mousewheel: deps: ['jquery']
      touchswipe: deps: ['jquery']
      scrollbar: deps: ['jquery','mousewheel']
      animate_css: deps: ['jquery']
      jarvix: deps: ['underscore', 'async']

   map:
      jquery_private:
         jquery: 'jquery'
         '*': jquery: 'scripts/libs/jquery/jquery.private'

require.onError = (required_type, required_modules)->
   console.error required_type
   console.error required_modules

# define main AMD module.
define [
   'dom_ready'
   'jquery_ui'
   'jarvix'
   'scripts/menu'
   'scripts/widgets/localizer'
   'scripts/widgets/slider'
   'scripts/widgets/breadcrumber'
   'scrollbar'
], (dom_ready, $, jx)->


   # load stylesheets.
   jx.load.stylesheets [
      'styles/libs/jquery/themes/dark_hive/jquery-ui-1.10.3.custom.css'
      'styles/libs/jquery/scrollbar/jquery.scrollbar.css'
      'styles/libs/animate.css'
      'styles/eurekaa.css'
      'styles/fonts.css'
   ]


   # wait for dom to be ready.
   dom_ready (dom)->

      try
         # create localizer.
         localizer = $('#localizer').localizer(locale: 'it').data 'widgets-localizer'

         #create breadcrumber.
         breadcrumber = $('#breadcrumber').breadcrumber().data 'widgets-breadcrumber'

         # create slider.
         slider = $('#slider').slider().data 'widgets-slider'  

         # create menu.
         $('nav').menu 
            localizer: localizer
            breadcrumber: breadcrumber
            slider: slider

         # create custom scrollbar.
         $('#layout').css height: $(window).height() + 'px'
         $('#layout').scrollbar()

         # resize scrollbar when window is resized.
         $(window).on 'resize', -> $('#layout').css height: $(window).height() + 'px'

         # load pages.         
         $('#slider').filter('[data-page]').each (i, item)->
            item = $(item)
            page = item.attr 'data-page'
            require ['text!pages/' + page + '.html!strip'], (page)->
               localizer.localize $(page), (err, page)-> item.html page

      catch err then console.error err