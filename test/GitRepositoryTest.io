Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testInitializingARepositoryCreatesDirectoryAndInitsRepoInIt := method (
    directory := TempDirectory directoryNamed(call message name)
    directory testExtras recursivelyRemove
    GitRepository clone setDirectory(directory) gitInit
    assertTrue(directory exists)
    assertTrue(directory directoryNamed(".git") exists)
  )
)
