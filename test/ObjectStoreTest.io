Lobby doRelativeFile("TestHelper.io")

ObjectStoreTestObject := Object clone do (
  newSlot("someField"); savedSlots := list("someField")
)

UnitTest clone do (
  testInsertedObjectsCanBeFoundById := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := ObjectStoreTestObject clone setSomeField("value")
    objStore save(obj)

    assertEquals(obj id, objStore objectStoreTestObject(obj id) id)
    assertEquals("value", objStore objectStoreTestObject(obj id) someField)
  )

  testInsertedObjectsCanBeFoundByList := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    objStore save(ObjectStoreTestObject clone setSomeField("value 1"))
    objStore save(ObjectStoreTestObject clone setSomeField("value 2"))

    assertEquals(list("value 1", "value 2"), 
                 objStore objectStoreTestObjects map(someField))
  )

  testInsertedObjectsCanBeFoundInAnotherObjectStoreWithTheSamePath := method(
    objStore1 := ObjectStore clone setPath(TempDirectory testFile path)
    objStore2 := ObjectStore clone setPath(TempDirectory testFile path)

    obj := ObjectStoreTestObject clone setSomeField("value")
    objStore1 save(obj)

    assertEquals("value", objStore2 objectStoreTestObject(obj id) someField)
  )

  testAndParentDirectoriesOnPathAreCreatedAsNeeded := method(
    objStore := ObjectStore clone setPath(TempDirectory testDir fileNamed("test") path)
    assertFalse(File with(objStore path) containingDirectory exists)

    objStore save(ObjectStoreTestObject clone)
    
    assertEquals(1, objStore objectStoreTestObjects size)
  )

  testRaisesAnErrorIfTypeCannotBeFoundForTable := method(
    objStore := ObjectStore clone setPath(TempDirectory testDir fileNamed("test") path)
    otherType := ObjectStoreTestObject clone
    otherType type := "FakeType"

    objStore save(otherType)

    assertRaisesException(objStore fakeTypes)
  )

  testFindingAnObjectTwiceByIdReturnsTheSameInstance := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := ObjectStoreTestObject clone setSomeField("value")
    objStore save(obj)

    # reinitialize the object store to get a fresh state
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    assertEquals(objStore objectStoreTestObject(obj id) uniqueId, 
                 objStore objectStoreTestObject(obj id) uniqueId)
  )

  testFindingAnObjectListTwiceReturnsTheSameInstances := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := ObjectStoreTestObject clone setSomeField("value")
    objStore save(obj)

    # reinitialize the object store to get a fresh state
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    assertEquals(objStore objectStoreTestObjects map(uniqueId), 
                 objStore objectStoreTestObjects map(uniqueId))
  )

  testObjectsReturnedByObjectStoreAreCollectedWhenNoReferencesRemain := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := ObjectStoreTestObject clone setSomeField("value")
    objStore save(obj)

    # reinitialize the object store to get a fresh state
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    oldUniqueId := objStore objectStoreTestObject(obj id) uniqueId

    Collector collect
    assertNotEquals(oldUniqueId, objStore objectStoreTestObject(obj id) uniqueId)
  )

  testFindingASavedObjectReturnsTheSavedObjectInstance := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    obj := ObjectStoreTestObject clone setSomeField("value")
    objStore save(obj)

    assertEquals(obj uniqueId, objStore objectStoreTestObject(obj id) uniqueId)
  )
)
