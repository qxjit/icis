Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testInitializingARepositoryCreatesDirectoryAndInitsRepoInIt := method(
    GitRepository at(TempDirectory testDir) gitInit
    assertTrue(TempDirectory testDir exists)
    assertTrue(TempDirectory testDir directoryNamed(".git") exists)
  )

  testCloningAGitRepositoryCreatesDirectoryAsACloneOfAnotherRepo := method(
    masterRepo := GitRepository at(TempDirectory testDir directoryNamed("master repo"))
    cloneRepo := GitRepository at(TempDirectory testDir directoryNamed("clone repo"))

    masterRepo gitInit
    # Git doesn't like to clone without a commit
    masterRepo gitDo(masterRepo directory, "commit", "--allow-empty", "-m", "test")

    assertEquals(cloneRepo, cloneRepo gitClone(masterRepo directory path))
    assertTrue(cloneRepo directory exists)
    assertEquals(masterRepo directory path, cloneRepo originUrl)
  )

  testCloningAGitRepositoryTwiceIsHarmless := method(
    masterRepo := GitRepository at(TempDirectory testDir directoryNamed("master repo"))
    cloneRepo := GitRepository at(TempDirectory testDir directoryNamed("clone repo"))

    masterRepo gitInit
    # Git doesn't like to clone without a commit
    masterRepo gitDo(masterRepo directory, "commit", "--allow-empty", "-m", "test")

    2 repeat(
      assertEquals(cloneRepo, cloneRepo gitClone(masterRepo directory path))
    )
  )

  testGitDoRaisesExceptionIfCommandFails := method(
    repo := GitRepository at(TempDirectory testDir)
    repo gitInit

    # pull will fail since there is no origin
    assertRaisesException(repo gitDo(repo directory, "pull"))
  )
)
