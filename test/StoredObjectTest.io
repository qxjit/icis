Lobby doRelativeFile("TestHelper.io")

FakeStoredObject := StoredObject clone do (
  storedFields("field1", "field2")
)

UnitTest clone do (
  testStoredObjectsAreSavedWithAllFields := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    object := FakeStoredObject clone setField1("1") setField2("2")
    objStore save(object)

    retrievedObject := objStore fakeStoredObject(object id)
    assertEquals(object field1, retrievedObject field1)
    assertEquals(object field2, retrievedObject field2)
  )
)
