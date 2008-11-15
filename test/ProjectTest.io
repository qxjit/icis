UnitTest clone do (
  setUp := method(
    resend
    testName := call sender n # UnitTest doesn't instantiate a separate instance for each test run...
    PDB setPath(TempDirectory fileNamed(testName .. ".tc") path)
  )

  testSavedProjectsCanBeFindByList := method(
    Project clone setName("Project 1") save
    Project clone setName("Project 2") save

    PDB close
    PDB open

    assertEquals(list("Project 1", "Project 2"),
                 Project all map(name))
  )
)
