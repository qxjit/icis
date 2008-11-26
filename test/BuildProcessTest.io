UnitTest clone do (
  testClonesRepositoryAndRunsBuildCommandInProjectDirectory := method(
    masterRepo := GitRepository at(TempDirectory testDir directoryNamed("master"))
    masterRepo gitInit

    # Git doesn't like to clone without a commit
    masterRepo gitDo(masterRepo directory, "commit", "--allow-empty", "-m", "test")

    project := Project clone setUrl(masterRepo directory path) \
                             setName("project") \
                             setBuildCommand("touch buildWasRun")

    build := BuildProcess clone setProject(project) \
                                setProjectDirectory(TempDirectory testDir) start

    assertEquals(false, build isSuccessful)
    assertEquals(true, build isRunning)
    waitFor(build isRunning not)
    assertEquals(true, build isSuccessful)
    assertTrue(TempDirectory testDir fileNamed("project/buildWasRun") exists)
    
    clonedRepo := GitRepository at(TempDirectory testDir directoryNamed("project"))
    assertEquals(clonedRepo originUrl, masterRepo directory path)
  )

  testBuildProcessIsNotSuccessfulIfGitCloneFails := method(
    TempDirectory testDir create

    project := Project clone setUrl(TempDirectory testDir directoryNamed("master")) \
                             setName("project") \
                             setBuildCommand("touch buildWasRun")

    build := BuildProcess clone setProject(project) \
                                setProjectDirectory(TempDirectory testDir) start

    waitFor(build isRunning not)
    assertEquals(false, build isSuccessful)
  )

  testBuildProcessIsNotSuccessfulIfBuildCommandFails := method(
    masterRepo := GitRepository at(TempDirectory testDir directoryNamed("master"))
    masterRepo gitInit

    # Git doesn't like to clone without a commit
    masterRepo gitDo(masterRepo directory, "commit", "--allow-empty", "-m", "test")

    project := Project clone setUrl(masterRepo directory path) \
                             setName("project") \
                             setBuildCommand("test -f bogus")

    build := BuildProcess clone setProject(project) \
                                setProjectDirectory(TempDirectory testDir) start

    waitFor(build isRunning not)
    assertEquals(false, build isSuccessful)
  )

  waitFor := method(
    startTime := Date now
    while(startTime secondsSinceNow < 1 and call evalArgAt(0) not, yield)
  )

)
