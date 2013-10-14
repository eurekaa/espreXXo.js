# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: require
# Created: 10/09/13 14.08

jX = require 'jarvix'
jX.module.define 'load', [], ()->


   stylesheets: (urls)->
      if not jX.utility.is_array urls then urls = new Array(urls)
      for url in urls
         link = document.createElement 'link'
         link.type = 'text/css'
         link.rel = 'stylesheet'
         link.href = url
         document.getElementsByTagName('head')[0].appendChild(link)
      return true


   i18n: (url, callback)->

      # if url is not valid return himself.
      if not jX.string.starts_with url, 'i18n://' then return callback null, url

      # localize label
      file = url.split('#')
      label = file[1]
      file = file[0].replace 'i18n://', 'i18n/'
      file = file.split '/'
      name = file.pop().replace '.js', ''
      file = file.join '/'
      locale = sessionStorage.getItem 'locale'
      require [file + '/' + locale + '/' + name], (content)->
         callback null, content[label]