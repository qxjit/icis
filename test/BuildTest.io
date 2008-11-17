Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testBuildCanBeAssociatedWithAProject := method(
    project := Project clone
    project id := "10"
    build := Build clone setProject(project)
    assertEquals("10", build projectId)
  )
)
