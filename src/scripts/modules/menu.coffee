# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: menu
# Created: 16/08/13 10.24

define ['jquery', 'i18n!scripts/modules/nls/menu', 'scripts/modules/utils'], (jQuery, lang, utils)->
   (container)->

      # create menu markup.
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


      $(container).html html