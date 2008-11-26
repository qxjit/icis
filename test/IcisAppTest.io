Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testDatabaseIsStoredWithinProjectDirectory := method(
    app := IcisApp clone
    app setProjectDirectory(Directory with("/some/dir"))
    assertEquals("/some/dir/projects.sqlite", app objStore path)
  )

)
