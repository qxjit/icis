Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testInitializingARepositoryCreatesDirectoryAndInitsRepoInIt := method(
    directory := TempDirectory directoryNamed(call message name)
    directory testExtras recursivelyRemove
    GitRepository at(directory) gitInit
    assertTrue(directory exists)
    assertTrue(directory directoryNamed(".git") exists)
  )

  testCloningAGitRepositoryCreatesDirectoryAsACloneOfAnotherRepo := method(
    testDir := TempDirectory directoryNamed(call message name)
    testDir testExtras recursivelyRemove
    masterRepo := GitRepository at(testDir directoryNamed("master"))
    cloneRepo := GitRepository at(testDir directoryNamed("clone"))

    masterRepo gitInit
    # Git doesn't like to clone without a commit
    masterRepo gitDo(masterRepo directory, "commit", "--allow-empty", "-m", "test")
    cloneRepo gitClone(masterRepo directory path)

    assertTrue(cloneRepo directory exists)
    assertEquals(list("origin/HEAD", "origin/master"),
                 File clone popen("cd " .. cloneRepo directory path .. " && git branch -r") readLines map(strip))
  )
)
