Lobby doRelativeFile("TestHelper.io")


UnitTest clone do (
  testABuildProcessIsRunningAfterItIsStartedTransfersToNotRunningWhenFinished := method(
    build := BuildProcess clone setCommand("sleep 0.01") start
    assertTrue(build isRunning)
    waitFor(build isRunning not)
    assertFalse(build isRunning)
  )

  testBuildProcessIsSuccessfulWhenCommandSucceeds := method(
    build := BuildProcess clone setCommand("sleep 0") start
    assertFalse(build isSuccessful)
    waitFor(build isRunning not)
    assertTrue(build isSuccessful)
  )

  testBuildProcessIsNotSuccessfulWhenCommandFails := method(
    build := BuildProcess clone setCommand("test -f bogus") start
    assertFalse(build isSuccessful)
    waitFor(build isRunning not)
    assertFalse(build isSuccessful)
  )

  testBuildProcessIsNotSuccessfulIfCommandIsNil := method(
    build := BuildProcess clone setCommand(nil) start
    assertFalse(build isSuccessful)
    waitFor(build isRunning not)
    assertFalse(build isSuccessful)
  )

  testBuildProcessCollectsOutputFromRun := method(
    build := BuildProcess clone setCommand("echo hello") start
    waitFor(build isRunning not)
    assertEquals("hello\n", build output)
  )

  testBuildProcessRunsInRequestedDirectory := method(
    build := BuildProcess clone setDirectory(TempDirectory) setCommand("pwd") start
    waitFor(build isRunning not)
    assertEquals(TempDirectory path .. "\n", build output)
  )

  waitFor := method(
    startTime := Date now
    while(startTime secondsSinceNow < 1 and call evalArgAt(0) not, yield)
  )
)
