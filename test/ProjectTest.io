Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testProjectCreateNewBuildsWithItsId := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    
    project := Project clone
    objStore save(project)

    assertEquals(project id, project newBuild projectId)
  )
)
