# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: curriculum
# Created: 30/08/13 9.23

define ['jquery_ui', 'jarvix', 'mosaix', 'quadrix'], ($, jX, mX, qX)->
   
   mX.load.stylesheets ['styles/curriculum.css']
   
   qX.widget.define 'eK.curriculum',
      
      _create: ->
         @.render (err)-> if err then console.error err
   
      render: (callback)->
         self = @
         
         require ['i18n/' + qX.localizer.get_locale() + '/curriculum_stefano_graziato'], (curriculum)->
            html = ''
            html += '<div class="accordion">'
            jX.async.eachSeries jX.object.keys(curriculum), (section, next)->
               html += '<h1>' + curriculum[section]['title'] + '</h1><div class="container">'
               
               jX.async.eachSeries jX.object.keys(curriculum[section]['properties']), (property, next)->
                  html += '<div class="label">' + curriculum[section]['properties'][property]['label'] + '</div>'
                  html += '<div class="value">' + curriculum[section]['properties'][property]['value'] + '</div>'
                  next()
               , (err)->
                  html += '</div>'
                  next err

            , (err)->
               if err then callback err
                  
               html += '</div>' 
               self.element.html html
               
               console.log self.element.find('.accordion')[0]
               self.element.find('.accordion').qX 'accordion',
                  active: false
               , -> console.log 'created'
                  
               callback null
         
         
      _destroy: ->