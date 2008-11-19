ObjectStoreList := Object clone do (
  newSlot("objStore")
  newSlot("conditions")
  newSlot("objectProto")

  lazySlot("rawList",
    inflector := objStore inflectorProto with(objectProto type)
    Message fromString(inflector multipleItemQueryName .. "(conditions)") \
            doInContext(objStore, self)
  )

  with := method(objStore, objectProto, conditions,
    self clone setObjStore(objStore) setObjectProto(objectProto) setConditions(conditions)
  )

  list("size", "first", "second", "third", "last", "at", 
       "contains", "containsAll", "containsAny",
       "foreach", "indexOf", "isEmpty", "isNotEmpty",
       "map", "select", "detect", "slice", "sortBy") foreach(methodName,
    setSlot(methodName, method(call delegateTo (rawList)))
  )
)
