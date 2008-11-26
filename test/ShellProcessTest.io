UnitTest clone do (
  testAShellProcessIsRunningAfterItIsStartedTransfersToNotRunningWhenFinished := method(
    proc := ShellProcess clone setCommand("sleep 0.01") start
    assertTrue(proc isRunning)
    assertFalse(proc whenDone isRunning)
  )

  testShellProcessIsSuccessfulWhenCommandSucceeds := method(
    proc := ShellProcess clone setCommand("sleep 0") start
    assertFalse(proc isSuccessful)
    assertTrue(proc whenDone isSuccessful)
  )

  testShellProcessIsNotSuccessfulWhenCommandFails := method(
    proc := ShellProcess clone setCommand("test -f bogus") start
    assertFalse(proc isSuccessful)
    assertFalse(proc whenDone isSuccessful)
  )

  testShellProcessIsNotSuccessfulIfCommandIsNil := method(
    proc := ShellProcess clone setCommand(nil) start
    assertFalse(proc isSuccessful)
    assertFalse(proc whenDone isSuccessful)
  )

  testShellProcessCollectsOutputFromRun := method(
    proc := ShellProcess clone setCommand("echo hello") start
    assertEquals("hello\n", proc whenDone output)
  )

  testShellProcessRunsInRequestedDirectory := method(
    proc := ShellProcess clone setDirectory(TempDirectory) setCommand("pwd") start
    assertEquals(TempDirectory path .. "\n", proc whenDone output)
  )
)
