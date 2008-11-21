Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testInflectionsBasedOnTableName := method(
    inflector := Inflector with("shoppingCarts")

    assertEquals("shoppingCarts", inflector tableName)
    assertEquals("shoppingCarts", inflector multipleItemQueryName)
    assertEquals("shoppingCart", inflector singleItemQueryName)
    assertEquals("ShoppingCart", inflector typeName)
    assertEquals("shoppingCartId", inflector foreignKeyName)
  )

  testInflectionsBasedOnSingleItemQueryName := method(
    inflector := Inflector with("shoppingCart")

    assertEquals("shoppingCarts", inflector tableName)
    assertEquals("shoppingCarts", inflector multipleItemQueryName)
    assertEquals("shoppingCart", inflector singleItemQueryName)
    assertEquals("ShoppingCart", inflector typeName)
    assertEquals("shoppingCartId", inflector foreignKeyName)
  )

  testInflectionsBasedOnTypeName := method(
    inflector := Inflector with("ShoppingCart")

    assertEquals("shoppingCarts", inflector tableName)
    assertEquals("shoppingCarts", inflector multipleItemQueryName)
    assertEquals("shoppingCart", inflector singleItemQueryName)
    assertEquals("ShoppingCart", inflector typeName)
    assertEquals("shoppingCartId", inflector foreignKeyName)
  )

  testCacheKeyForAnIdIsTypeNameColonId := method(
    assertEquals("ShoppingCart:10", 
                 Inflector with("ShoppingCart") cacheKey(10))
  )
)
