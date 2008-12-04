Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testExecRaisesAnErrorWhenOneIsPresent := method (
    adapter := SQLite3Adapter close setPath(TempDirectory testFile path)
    adapter open
    e := try(assertRaisesException(adapter exec("nonsensical sql")))
    adapter close
    e pass
  )

  testExecDoesNotRaiseErrorWhenNoneIsPresent := method (
    adapter := SQLite3Adapter close setPath(TempDirectory testFile path)
    adapter open
    e := try(adapter exec("select 1"))
    adapter close
    e pass
  )

  testCallingOpenMoreThanOnceDoesntLeakFileHandles := method (
    adapter := SQLite3Adapter close setPath(TempDirectory testFile path)

    adapter open
    adapter open
    adapter close

    proc := ShellProcess clone setCommand("lsof | grep #{adapter path} | wc -l" interpolate)
    proc run
    assertEquals(0, proc output strip asNumber)
  )

  testOpenReturnsSelf := method (
    adapter := SQLite3Adapter close setPath(TempDirectory testFile path)

    e := try (
      assertEquals(adapter, adapter open)
      assertEquals(adapter, adapter open)
    )
    adapter close
    e pass
  )
)
