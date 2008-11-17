Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  FakeBuildProcess := Object clone do (
    instances := list

    newSlot("command", nil)
    newSlot("isRunning", false)

    init := method(instances append(self))

    start := method(setIsRunning(true))
  )

  setUp := method(resend; FakeBuildProcess instances empty)

  testBuildManagerStartsBuildProcessesForAnyProjectsWithoutABuild := method (
    manager := BuildManager clone setApplication(application) setBuildProcessProto(FakeBuildProcess)

    objStore save(Project clone setBuildCommand("doit"))

    manager updateProcesses

    assertEquals(1, FakeBuildProcess instances size)
    assertEquals("doit", FakeBuildProcess instances first command)
    assertTrue(FakeBuildProcess instances first isRunning)
  )

  testBuildManagerDoesntStartBuildProcessForProjectsWithABuild := method (
    manager := BuildManager clone setApplication(application) setBuildProcessProto(FakeBuildProcess)

    objStore save(project := Project clone setBuildCommand("doit"))
    objStore save(project newBuild)

    manager updateProcesses

    assertEquals(0, FakeBuildProcess instances size)
  )
)
