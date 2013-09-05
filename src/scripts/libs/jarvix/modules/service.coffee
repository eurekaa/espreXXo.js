# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: require
# Created: 01/09/13 6.32

define ->
   
   call: (url, callback)->
      method = url.split('://')[0]
      if @[method] then @[method].apply @, arguments
   
   lang: @.i18n
   i18n: (url, callback)->
      file = url.split('#')
      label = file[1]
      file = file[0].replace 'i18n://', 'langs/'
      file = file.split '/'
      name = file.pop().replace '.js', ''
      file = file.join '/'
      locale = sessionStorage.getItem 'locale'
      require [file + '/' + locale + '/' + name], (content)-> 
         callback null, content[label]