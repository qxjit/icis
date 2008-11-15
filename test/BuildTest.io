Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testABuildIsRunningAfterItIsStartedTransfersToNotRunningWhenFinished := method(
    build := Build clone setCommand("sleep 0.01") start
    assertTrue(build isRunning)
    wait(0.05)
    assertFalse(build isRunning)
  )

  testBuildIsStillRunnngIfTheCommandHasntFinishedYet := method(
    build := Build clone setCommand("sleep 0.05") start
    assertTrue(build isRunning)
    wait(0.01)
    assertTrue(build isRunning)
  )

  testBuildIsSuccessfulWhenCommandSucceeds := method(
    build := Build clone setCommand("sleep 0") start
    assertFalse(build isSuccessful)
    while(build isRunning, yield)
    assertTrue(build isSuccessful)
  )

  testBuildIsNotSuccessfulWhenCommandFails := method(
    build := Build clone setCommand("test -f bogus") start
    assertFalse(build isSuccessful)
    while(build isRunning, yield)
    assertFalse(build isSuccessful)
  )
)
