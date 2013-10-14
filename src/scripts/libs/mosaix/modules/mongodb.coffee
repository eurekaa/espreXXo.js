# Company: Eureka²
# Developer: Stefano Graziato
# Email: stefano.graziato@eurekaa.it
# Homepage: http://www.eurekaa.it
# GitHub: https://github.com/eurekaa

# File Name: mongodb
# Created: 01/10/13 15.37

jX = require 'jarvix'
jX.module.define 'mongodb', [
   'confix'
   'node://mongodb'
   'jX://utility'
], (cX, mongodb, utility)->

   # name of the identity field in database.
   IDENTITY: cX.store['mongodb'].identity

   # opens a new connection to mongodb database.
   connect: (callback) ->
      server = new mongodb.Server cX.store['mongodb'].host, cX.store['mongodb'].port, {}
      server = new mongodb.Db cX.store['mongodb'].name, server, safe: true
      server.open (err, client)-> callback err, client
   
   
   # converts a string into an object_id for mongodb.
   object_id: (id) -> return new mongodb.ObjectID id
   
   
   # converts a string into a 'code' object to be stored in mongodb.
   code: (code, context)-> return new mongodb.Code code, context
   
   
   # normalizes query.
   # query = { select: ['field1','field2','..'], where: {_id: { $in: [..]} }, limit: [0,n], command: {..} }
   normalize_query: (query, callback) ->
      self = @
      query = query || {}
      try
   
         # normalize 'select' statement.
         query.select = query.select || {}
         if jX.utility.is_array query.select
            select = {}
            select[query.select[key]] = true for key in query.select
            query.select = select
      
         # normalize 'limit' statement.
         query.limit = if query.limit and jX.utility.is_array query.limit then query.limit else [undefined, undefined]
         
         # normalize 'where' statement. (_id > object_id(_id)).
         query.where = query.where || {}
         for key in jX.object.keys(query.where) when key.indexOf(self.IDENTITY) != -1
            if query.where[key]['$in'] then query.where[key]['$in'] = jX.list.map query.where[key]['$in'], (id, i)-> self.object_id id
            else query.where[key] = self.object_id query.where[key]
         
         # callback normalized query.
         callback null, query
      catch err then callback err


   # performs a query on a collection.
   find: (collection, query, options, callback) ->
      self = @
      options = options || {}
      query = query || {}

      # open connection and normalize query.
      jX.async.parallel  
         connection: (_)-> if options.connection then _ null, options.connection else self.connect _
         query: (_)-> self.normalize_query query, _
      , (err, connection, query)->
            if err then return callback err
            
            # execute query.
            collection = mongodb.Collection connection, collection
            collection = collection.find query.where, query.select
            collection = collection.skip query.limit[1]
            collection = collection.limit query.limit[0]
            collection.toArray callback
   
   
   # inserts a new document in a collection.
   insert: (collection, document, options, callback) ->
      self = @
      options = options || {}
      
      # open a new connection if not provided.
      jX.async.if not options.connection,
         then: (_)-> self.connect _
         else: (_)-> _ null, options.connection
      , (err, connection)->
         if err then return callback err
         
         # document must not be an empty one.
         if jX.utility.is_empty document then return callback new Error 'trying to insert an empty document. operation is not allowed.'
         
         # document must have an identity field.
         if jX.utility.is_undefined document[self.IDENTITY] then return callback new Error 'trying to insert a document without identity. operation is not allowed.'
         
         # transform identity.
         document[self.IDENTITY] = self.object_id document[self.IDENTITY]
         
         # insert new document.
         collection = mongodb.Collection connection, collection
         collection.insert document, safe: true, callback
   
   
   # performs an update query.
   update: (collection, query, options, callback)->
      self = @
      options = options || {}
      
      # open connection and normalize query.
      jX.async.parallel
         connection: (_)-> if options.connection then _ null, options.connection else self.connect _
         query: (_)-> self.normalize_query query, _
      , (err, connection, query)->
         if err then return callback err
         
         # execute update query.
         collection = mongodb.Collection connection, collection
         return collection.update query.where, query.command, { safe: true, multi: true }, callback
   
   
   # removes documents from a collection.
   remove: (collection, query, options, callback)->
      self = @
      options = options || {}

      # open connection and normalize query.
      jX.async.parallel
         connection: (_)-> if options.connection then _ null, options.connection else self.connect _
         query: (_)-> self.normalize_query query, _
      , (err, connection, query)->
         if err then return callback err
   
         # remove documents.
         collection = mongodb.Collection connection, collection
         return collection.remove query.where, safe: true, callback