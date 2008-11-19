Lobby doRelativeFile("TestHelper.io")

ObjectStoreListTestObject := Object clone do (
  newSlot("someField"); savedSlots := list("someField")
  != := method(other, id != other ifNonNilEval(id)) # for assertEquals
)

UnitTest clone do (
  testListLoadsObjectsFromObjectStoreMatchingConditions := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    objStore save(ObjectStoreListTestObject clone setSomeField("foo"))
    objStore save(ObjectStoreListTestObject clone setSomeField("bar"))

    objStoreList := ObjectStoreList with(objStore, 
                                         ObjectStoreListTestObject,
                                         "someField = 'foo'")

    assertEquals(1, objStoreList size)
    assertEquals("foo", objStoreList first someField)
  )

  testListDelegatesCommonListMethodsToRawList := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    objStore save(ObjectStoreListTestObject clone setSomeField("foo"))
    objStore save(ObjectStoreListTestObject clone setSomeField("bar"))

    realList := objStore objectStoreListTestObjects
    objStoreList := ObjectStoreList with(objStore, 
                                         ObjectStoreListTestObject,
                                         "1 = 1")

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

    assertEquals(realList foreach(someField), objStoreList foreach(someField))
    assertEquals(realList indexOf(realList first), 
                 objStoreList indexOf(realList first))

    assertEquals(realList isEmpty, objStoreList isEmpty)
    assertEquals(realList isNotEmpty, objStoreList isNotEmpty)
    assertEquals(realList last, objStoreList last)
    assertEquals(realList map(someField), objStoreList map(someField))
    assertEquals(realList detect(c, c someField == "foo"), 
                 objStoreList detect(c, c someField == "foo"))

    assertEquals(realList select(c, c someField == "foo"), 
                 objStoreList select(c, c someField == "foo"))

    assertEquals(realList size, objStoreList size)
    assertEquals(realList slice(1), objStoreList slice(1))
    assertEquals(realList sortBy(block(c, c someField)), 
                 objStoreList sortBy(block(c, c someField)))
  )
)
