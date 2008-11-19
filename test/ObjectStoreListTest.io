Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testListLoadsObjectsFromObjectStoreMatchingConditions := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    objStore save(LineItem clone setName("foo"))
    objStore save(LineItem clone setName("bar"))

    objStoreList := ObjectStoreList with(objStore, LineItem, "name = 'foo'")

    assertEquals(1, objStoreList size)
    assertEquals("foo", objStoreList first name)
  )

  testListDelegatesCommonListMethodsToRawList := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    objStore save(LineItem clone setName("foo"))
    objStore save(LineItem clone setName("bar"))

    realList := objStore lineItems
    objStoreList := ObjectStoreList with(objStore, LineItem, "1 = 1")

    assertEquals(realList first, objStoreList first)
    assertEquals(realList second, objStoreList second)
    assertEquals(realList third, objStoreList third)
    assertEquals(realList at(0), objStoreList at(0))

    assertEquals(realList contains(realList first), 
                 objStoreList contains(realList first))

    assertEquals(realList containsAll(realList), 
                 objStoreList containsAll(realList))

    assertEquals(realList containsAny(realList), 
                 objStoreList containsAny(realList))

    assertEquals(realList foreach(name), objStoreList foreach(name))
    assertEquals(realList indexOf(realList first), 
                 objStoreList indexOf(realList first))

    assertEquals(realList isEmpty, objStoreList isEmpty)
    assertEquals(realList isNotEmpty, objStoreList isNotEmpty)
    assertEquals(realList last, objStoreList last)
    assertEquals(realList map(name), objStoreList map(name))
    assertEquals(realList detect(i, i name == "foo"), 
                 objStoreList detect(i, i name == "foo"))

    assertEquals(realList select(i, i name == "foo"), 
                 objStoreList select(i, i name == "foo"))

    assertEquals(realList size, objStoreList size)
    assertEquals(realList slice(1), objStoreList slice(1))
    assertEquals(realList sortBy(block(i, i name)), 
                 objStoreList sortBy(block(i, i name)))
  )
)
