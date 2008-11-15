Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testSavedProjectsFound := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)

    objStore save(Project clone setName("Project 1") setUrl("/some/url1"))

    assertEquals(list("Project 1"), objStore projects map(name))
    assertEquals(list("/some/url1"), objStore projects map(url))
  )
)
