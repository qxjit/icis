Inflector := Object clone do (
  with := method(string, self clone setSource(string))

  setSource := method(string,
    self source := string asMutable removeSuffix("s") makeFirstCharacterLowercase
    self
  )

  tableName := method(source .. "s")
  multipleItemQueryName := method(tableName)
  singleItemQueryName := method(source)
  typeName := method(source asCapitalized)
  cacheKey := method(id, typeName .. ":" .. id asString)
  foreignKeyName := method(source .. "Id")
)
