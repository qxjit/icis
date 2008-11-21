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
)
