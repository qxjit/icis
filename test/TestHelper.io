hasSlot("TestDirectory") ifFalse(
  Lobby doRelativeFile("../app/Init.io")

  TestDirectory := File clone setPath(Path thisSourceFilePath) containingDirectory
  InfrastructureDirectory := TestDirectory directoryNamed("infrastructure")
  Importer addSearchPath(InfrastructureDirectory path)
  Lobby doFile(InfrastructureDirectory fileNamed("TestExtras.io") path)

  TempDirectory := TestDirectory directoryNamed("tmp") do (
    testFile := method(fileNamed(call sender call message name))
    testDir := method(directoryNamed(call sender call message name))
  )

  TempDirectory TestExtras recursivelyRemove
  TempDirectory create

  Regex # force Regex to load
)
