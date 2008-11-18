Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  FakeBuildProcess := Object clone do (
    instances := list

    newSlot("command", nil)
    newSlot("isRunning", false)

    init := method(instances append(self))

    start := method(setIsRunning(true))
  )

  setUp := method(
    resend
    FakeBuildProcess instances empty
    self manager := BuildManager clone setApplication(application) setBuildProcessProto(FakeBuildProcess)
  )

  testBuildManagerStartsBuildProcessesForAnyProjectsWithoutABuild := method (
    objStore save(Project clone setBuildCommand("doit"))

    manager updateProcesses

    assertEquals(1, FakeBuildProcess instances size)
    assertEquals("doit", FakeBuildProcess instances first command)
    assertTrue(FakeBuildProcess instances first isRunning)
  )

  testBuildManagerDoesntStartBuildProcessForProjectsWithABuild := method (
    objStore save(project := Project clone)
    objStore save(project newBuild)

    manager updateProcesses

    assertEquals(0, FakeBuildProcess instances size)
  )

  testBuildManagerCreatesABuildInRunningStatusStartingABuild := method (
    objStore save(project := Project clone)

    manager updateProcesses

    assertEquals(1, objStore builds size)
    assertEquals(project id, objStore builds first projectId)
    assertEquals(Build Status Running, objStore builds first status)
  )
)
