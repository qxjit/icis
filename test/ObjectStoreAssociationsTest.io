Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testAssocationFindsOnlyObjectsAssociatedWithParent := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    objStore save(order1 := Order clone)
    objStore save(item1a := LineItem clone setOrderId(order1 id))
    objStore save(item1b := LineItem clone setOrderId(order1 id))

    objStore save(order2 := Order clone)
    objStore save(item2a := LineItem clone setOrderId(order2 id))
    objStore save(item2b := LineItem clone setOrderId(order2 id))

    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    assertEquals(list(item1a id, item1b id), 
                 objStore order(order1 id) lineItems map(id))

    assertEquals(list(item2a id, item2b id), 
                 objStore order(order2 id) lineItems map(id))
  ) 
)
