# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: i18n
# Created: 22/08/13 18.

'use continuum'


define [
   'jquery'
   'scripts/lib/jarvix.js/utils'
], ($, utils)->

   set_locale: (locale)-> sessionStorage.setItem('locale', locale)
   get_locale: ()-> sessionStorage.getItem('locale')

   localize: (element, next)->
      # build jquery object.
      element = $(element)
      # move to parent to find each sibling element to be localized (including himself).
      element = element.parent()
      # find localizable elements.
      localizables = element.find '[data-i18n]'


      # check if element has data-i18n attribute
      if not utils.is_defined element.attr 'data-i18n' then throw 'argument is not a localizable element (it must have a "i18n" attribute.'
      # find label file and property.
      i18n_file = element.attr 'data-i18n'
      i18n_file = i18n_file.split '/'
      i18n_key = i18n_file.pop()
      i18n_file = i18n_file.join '/'
      # require appropriate file.
      locale = @.get_locale()
      locale = if utils.is_defined locale then locale + '/' else ''
      require ['i18n!pages/i18n/' + locale + i18n_file], __(i18n_file)
      # update label.
      element.html i18n_file[i18n_key]
      # callback with element returned back for chaining purposes.
      next element
