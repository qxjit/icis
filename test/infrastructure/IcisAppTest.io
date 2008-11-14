IcisAppTest := HttpAppTest clone do (
  setApplication(IcisApp)

  setUp := method(
    resend
    testName := call sender n # UnitTest doesn't instantiate a separate instance for each test run...
    application setProjectDirectory(TempDirectory directoryNamed(testName) directoryNamed("projects"))
  )
)
