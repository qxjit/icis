Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testInsertedObjectsCanBeFoundById := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := LineItem clone setName("value")
    objStore save(obj)

    assertEquals(obj id, objStore lineItem(obj id) id)
    assertEquals("value", objStore lineItem(obj id) name)
  )

  testInsertedObjectsCanBeFoundByList := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    objStore save(LineItem clone setName("value 1"))
    objStore save(LineItem clone setName("value 2"))

    assertEquals(list("value 1", "value 2"), 
                 objStore lineItems map(name))
  )

  testInsertedObjectsCanBeFoundInAnotherObjectStoreWithTheSamePath := method(
    objStore1 := ObjectStore clone setPath(TempDirectory testFile path)
    objStore2 := ObjectStore clone setPath(TempDirectory testFile path)

    obj := LineItem clone setName("value")
    objStore1 save(obj)

    assertEquals("value", objStore2 lineItem(obj id) name)
  )

  testAndParentDirectoriesOnPathAreCreatedAsNeeded := method(
    objStore := ObjectStore clone setPath(TempDirectory testDir fileNamed("test") path)
    assertFalse(File with(objStore path) containingDirectory exists)

    objStore save(LineItem clone)
    
    assertEquals(1, objStore lineItems size)
  )

  testRaisesAnErrorIfTypeCannotBeFoundForTable := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    otherType := LineItem clone
    otherType type := "FakeType"

    objStore save(otherType)

    # reinitialize the object store to get a fresh state
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    assertRaisesException(objStore fakeTypes)
  )

  testFindingAnObjectTwiceByIdReturnsTheSameInstance := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := LineItem clone setName("value")
    objStore save(obj)

    # reinitialize the object store to get a fresh state
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    assertEquals(objStore lineItem(obj id) uniqueId, 
                 objStore lineItem(obj id) uniqueId)
  )

  testFindingAnObjectListTwiceReturnsTheSameInstances := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := LineItem clone setName("value")
    objStore save(obj)

    # reinitialize the object store to get a fresh state
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    assertEquals(objStore lineItems map(uniqueId), 
                 objStore lineItems map(uniqueId))
  )

  testObjectsReturnedByObjectStoreAreCollectedWhenNoReferencesRemain := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := LineItem clone setName("value")
    objStore save(obj)

    # reinitialize the object store to get a fresh state
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    oldUniqueId := objStore lineItem(obj id) uniqueId

    Collector collect
    assertNotEquals(oldUniqueId, objStore lineItem(obj id) uniqueId)
  )

  testFindingASavedObjectReturnsTheSavedObjectInstance := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := LineItem clone setName("value")
    objStore save(obj)

    assertEquals(obj uniqueId, objStore lineItem(obj id) uniqueId)
  )

  testObjectListsCanBeFoundWithEquality := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    objStore save(LineItem clone setName("foo"))
    objStore save(LineItem clone setName("bar"))

    assertEquals(list("foo"), 
                 objStore lineItems("name = 'foo'") map(name))
  )
)
