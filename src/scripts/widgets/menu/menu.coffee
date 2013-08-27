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
   'i18n!scripts/modules/nls/menu'
   'scripts/modules/utils'
], ($, lang, utils) ->


   $.widget 'eurekaa.menu',

      options: {}

      _create: ()->

         html = """
          <ul>
          <li data-link='pages/home' class='active'><a href='#'> #{ utils.capitalize lang.home } </a></li>
          <li data-link='pages/eurekaa'><a href='#'> #{ utils.capitalize lang.eurekaa } </a></li>
          <li data-link='pages/services'><a href='#'> #{ utils.capitalize lang.services } </a></li>
          <li data-link='pages/curriculum'><a href='#'> #{ utils.capitalize lang.curriculum } </a></li>
          <li data-link='pages/portfolio'><a href='#'> #{ utils.capitalize lang.portfolio } </a></li>
          <li data-link='pages/projects'><a href='#'> #{ utils.capitalize lang.projects } </a></li>
          <li data-link='pages/contacts'><a href='#'> #{ utils.capitalize lang.contacts } </a></li>
          </ul>
          """

         @.element.html html

         @.element.find('ul li').bind 'click', @.load_page

      load_page: ()->
            link = $(@).attr 'data-link'
            page = ''
            require ['text!' + link + '.html!strip'], __(page)
            $('#main').html page
            $(@).addClass 'active'

      _destroy: ()->


