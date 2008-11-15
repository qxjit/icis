ObjectStore := Object clone do (
  # preload so we don't run into a loop trying to load it from the forward 
  SQLite3 
  newSlot("path")
  inflectorProto := Inflector
  lazySlot("db", 
    Directory with(path pathComponent) createIfAbsent
    SQLite3 clone setPath(path)
  )

  save := method(object, 
    db open
    tableName := inflectorProto with(object type) tableName
    columns := object savedSlots join(",")

    db exec("""create table if not exists #{tableName} 
                (id integer primary key not null, 
                #{columns})""" interpolate)

    values := object savedSlots map(c, "'#{object getSlot(c)}'" interpolate) join(",")

    db exec("""insert into #{tableName} (#{columns})
               values (#{values})""" interpolate)

    object id := db lastInsertRowId
    db close
  )

  forward := method(
    inflector := inflectorProto with(call message name)
    sql := "select * from #{inflector tableName}"

    if (singleItem := (inflector singleItemQueryName == call message name),
      sql = sql .. " where id = #{call evalArgAt(0)}"
    )

    db open
    rows := db exec(sql interpolate)
    db close

    objects := rows map(row,
      obj := Lobby doString(inflector typeName) clone
      row foreach(name, value, 
        (name == "id") ifTrue(value := value asNumber)
        obj setSlot(name, value)
      )
      obj
    )

    if (singleItem, objects first, objects)
  )
)
