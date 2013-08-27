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
   'async'
   'scripts/libs/jarvix/list'
   'scripts/libs/jarvix/utility'
], ($, async, list, utility)->
   

   set_locale: (locale)-> sessionStorage.setItem('locale', locale)
   get_locale: ()-> sessionStorage.getItem('locale')
   
   localize: (element, next)-> 
      # preserve context from asynchronous functions changing it.
      self = @             
      
      # run in parallel the localization of each localizable node.
      localizables = $(element).find '[data-i18n]'
      if localizables.length == 0 then next()
      else         
         async.each element.find('[data-i18n]'), (node, next)->
            # find label file and property.
            i18n_file = $(node).attr 'data-i18n'
            i18n_file = i18n_file.split '/'
            i18n_key = i18n_file.pop()
            i18n_file = i18n_file.join '/'
   
            # require appropriate file.  
            locale = self.get_locale()
            require ['i18n/' + locale + '/' + i18n_file], (i18n_file)->
               # localize node.
               $(node).html i18n_file[i18n_key]
               next()
               
         ,(err)-> if err then next err else next null, $(element)