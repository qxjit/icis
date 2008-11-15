Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testInflectionsBasedOnTableName := method(
    inflector := Inflector with("shoppingCarts")

    assertEquals("shoppingCarts", inflector tableName)
    assertEquals("shoppingCarts", inflector multipleItemQueryName)
    assertEquals("shoppingCart", inflector singleItemQueryName)
    assertEquals("ShoppingCart", inflector typeName)
  )

  testInflectionsBasedOnSingleItemQueryName := method(
    inflector := Inflector with("shoppingCart")

    assertEquals("shoppingCarts", inflector tableName)
    assertEquals("shoppingCarts", inflector multipleItemQueryName)
    assertEquals("shoppingCart", inflector singleItemQueryName)
    assertEquals("ShoppingCart", inflector typeName)
  )

  testInflectionsBasedOnTypeName := method(
    inflector := Inflector with("ShoppingCart")

    assertEquals("shoppingCarts", inflector tableName)
    assertEquals("shoppingCarts", inflector multipleItemQueryName)
    assertEquals("shoppingCart", inflector singleItemQueryName)
    assertEquals("ShoppingCart", inflector typeName)
  )
)
