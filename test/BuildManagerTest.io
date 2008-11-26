Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  FakeBuildProcess := Object clone do (
    instances := list

    newSlot("project", nil)
    newSlot("projectDirectory", nil)
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
    objStore save(project := Project clone setBuildCommand("doit"))

    manager updateProcesses

    assertEquals(1, FakeBuildProcess instances size)
    assertEquals(project id, FakeBuildProcess instances first project id)
    assertEquals(manager application projectDirectory,
                 FakeBuildProcess instances first projectDirectory)
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
