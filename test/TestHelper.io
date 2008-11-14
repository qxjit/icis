hasSlot("TestDirectory") ifFalse(
  Lobby doRelativeFile("../app/Init.io")
  TestDirectory := File clone setPath(Path thisSourceFilePath) containingDirectory
  Importer addSearchPath(TestDirectory directoryNamed("infrastructure") path)
  TempDirectory := TestDirectory directoryNamed("tmp") create
  Regex # force Regex to load

  TestExtras := Object clone do (
    Directory := Object clone do (
      recursivelyRemove := method (
        name in(list(".", "..")) ifFalse(
          items foreach(testExtras recursivelyRemove)
          remove
        )
      )
    )
    
    File := Object clone do (
      recursivelyRemove := method(remove)
    )
  )

  Object testExtras := method(
    self clone do (appendProto(TestExtras getSlot(type)))
  )
)
