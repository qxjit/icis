Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  FakeGitRepository := GitRepository clone do (
    newSlot("clonedFromUrl")
    gitClone := method(url, setClonedFromUrl(url))
  )

  testProjectCreateNewBuildsWithItsId := method(
    objStore := ObjectStore clone setPath(TempDirectory testFile path)
    
    project := Project clone
    objStore save(project)

    assertEquals(project id, project newBuild projectId)
  )

  testProjectClonesGitRepoIntoSpecifiedDirectory := method(
    testDir := TempDirectory testDir

    project := Project clone setName("TestProject") \
                             setGitRepositoryProto(FakeGitRepository) \
                             setUrl("repouri")

    repo := project newClonedRepositoryIn(testDir)
    assertEquals("repouri", repo clonedFromUrl)
    assertEquals(testDir directoryNamed("TestProject") path, repo directory path)
  )
)
