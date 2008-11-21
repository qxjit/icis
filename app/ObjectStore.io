ObjectStore := Object clone do (
  # preload so we don't run into a loop trying to load it from the forward 
  SQLite3Adapter
  newSlot("path")
  inflectorProto := Inflector
  lazySlot("db", 
    Directory with(path pathComponent) createIfAbsent
    SQLite3Adapter clone setPath(path)
  )

  init := method(
    resend
    self objectCache := Map clone
  )

  getCachedObject := method(cacheKey,
    if(self objectCache hasKey(cacheKey),
       objectCache at(cacheKey) link
    )
  )

  putObjectInCache := method(cacheKey, object,
    objectCache atPut(cacheKey, WeakLink clone setLink(object))
  )

  save := method(object, 
    inflector := inflectorProto with(object type)
    tableName := inflector tableName
    columns := object savedSlots join(",")

    db open
    db exec("""create table if not exists #{tableName} 
                (id integer primary key not null
                #{if(columns isZero, "", ",")} 
                #{columns})""" interpolate)

    values := object savedSlots map(c, "'#{object getSlot(c)}'" interpolate) join(",")

    db exec("""insert into #{tableName} 
               (id #{if(columns isZero, "", ",")} #{columns})
               values (null #{if(columns isZero, "", ",")} #{values})""" interpolate)

    object id := db lastInsertRowId asString
    db close

    putObjectInCache(inflector cacheKey(object id), object)
  )

  forward := method(
    inflector := inflectorProto with(call message name)
    inflector tableName in(db tableNames) ifFalse(return list())

    sql := "select * from #{inflector tableName}"

    if (singleItem := (inflector singleItemQueryName == call message name),
      sql = sql .. " where id = #{call evalArgAt(0)}"
    ,
      if(call hasArgs, sql = sql .. " where #{call evalArgAt(0)}")
    )

    db open
    rows := db exec(sql interpolate)
    db close

    objects := rows map(row,
      if(cachedObject := getCachedObject(inflector cacheKey(row at("id"))),
        cachedObject
      ,
        obj := Lobby doString(inflector typeName) clone
        row foreach(name, value, obj setSlot(name, value))
        if (obj hasSlot("associations"),
          obj associations foreach(association,
            obj setSlot(association, doString(
              """#{association}("#{inflector foreignKeyName} = '#{obj id}'")""" interpolate
              )
            )
          )
        )
        putObjectInCache(inflector cacheKey(obj id), obj)
        obj
      )
    )

    if (singleItem, objects first, objects)
  )
)
