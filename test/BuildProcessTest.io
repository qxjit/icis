Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testABuildProcessIsRunningAfterItIsStartedTransfersToNotRunningWhenFinished := method(
    build := BuildProcess clone setCommand("sleep 0.01") start
    assertTrue(build isRunning)
    wait(0.05)
    assertFalse(build isRunning)
  )

  testBuildProcessIsStillRunnngIfTheCommandHasntFinishedYet := method(
    build := BuildProcess clone setCommand("sleep 0.05") start
    assertTrue(build isRunning)
    wait(0.01)
    assertTrue(build isRunning)
  )

  testBuildProcessIsSuccessfulWhenCommandSucceeds := method(
    build := BuildProcess clone setCommand("sleep 0") start
    assertFalse(build isSuccessful)
    while(build isRunning, yield)
    assertTrue(build isSuccessful)
  )

  testBuildProcessIsNotSuccessfulWhenCommandFails := method(
    build := BuildProcess clone setCommand("test -f bogus") start
    assertFalse(build isSuccessful)
    while(build isRunning, yield)
    assertFalse(build isSuccessful)
  )
)
