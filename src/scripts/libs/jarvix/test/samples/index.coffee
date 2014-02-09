# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: index
# Created: 26/01/14 21.33

jx.library.define 'sample',
   version: '0.0.1'    
   config: 'jarvix://test/samples/config'
   base_path: 'scripts/libs/jarvix/test/samples/'
, ['jarvix://date', 'jarvix://object']
, (date, object)->
   
      date: date
      object: object