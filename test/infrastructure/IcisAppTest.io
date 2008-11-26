IcisAppTest := HttpAppTest clone do (
  setUp := method(
    resend
    testName := call sender n # UnitTest doesn't instantiate a separate instance for each test run...
    setApplication(IcisApp clone setProjectDirectory(TempDirectory directoryNamed(testName) directoryNamed("projects")))
    self objStore := application objStore
  )
)
