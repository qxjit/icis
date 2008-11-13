if (hasSlot("TestDirectory") not,
  Lobby doRelativeFile("../app/Init.io")
  TestDirectory := File clone setPath(Path thisSourceFilePath) containingDirectory
  Importer addSearchPath(TestDirectory directoryNamed("infrastructure") path)
  TempDirectory := TestDirectory directoryNamed("tmp") create
  Regex # force Regex to load
)
