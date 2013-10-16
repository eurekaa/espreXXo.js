# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: test
# Created: 08/08/13 20.59


jX = require 'jarvix'
jX.module.define 'menu', [
   'jquery_ui'
   'mosaix'
   'quadrix'
], ($, mX, qX) ->
   
   
   qX.element.define 'qX.menu',
      
      options:
         stylesheet: 'styles/menu.css'
         class: 'menu'
         widgets:
            qX:
               breadcrumber: null
               panel: null
      
      
      _render: (callback)->
         html = '<ul>'
         jX.list.each @.options.dataset, (row, i)->
            html += '<li class="' + (if row.active == true then 'active' else '') + '" data-label="' + row.id + '" data-link="' + row.data + '"></li>'
         html += '</ul>'
         @.element.html html
         
         callback null
      
      
      _ready: (callback)->
         self = @
         
         # bind click events.
         @.element.find('li').on 'click', (event)->
            element = $(event.target)
            if element.hasClass 'active' then return
            else self.change element.attr 'data-label'

         callback null



      _localize: (callback)->
         @.element.find('li').each (i, item)->
            item = $(item)
            item.animate_css 'bounceInDown', (100 * ++i)
            qX.localizer.localize item, ->

         callback null


      change: (label)->
         self = @
         widgets = self.options.widgets.qX
         element = self.element.find '[data-label="' + label + '"]'
         
         # load new page.
         page = element.attr('data-link').replace('tile://', 'tiles/')
         widgets.panel.load page, (err)->
            if err then console.error err

         # change menu status.
         self.element.find('li').each (i, item)-> $(item).removeClass 'active'
         element.addClass 'active'
         
         # change breadcrumb.
         #if self.options.breadcrumber
         #self.options.breadcrumber.reset(jX.utility.to_capitalized(element.html()))


      _destroy: ->
         @.element.removeClass @.options.class