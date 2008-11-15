Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  testIndexDisplaysAdminBanner := method (
    response := get("/admin")
    assertEquals("Welcome to Icis - Admin", response page at("title") allText)
  )

  testIndexBeforeAddingProjectDisplaysNoProjects := method (
    response := get("/admin")
    projects := response page findElements(class == "project")
    assertEquals(0, projects size)
  )

  testIndexWithProjectsAlreadyAddedDisplaysProjectsWithNames := method (
    application objStore save(Project clone setName("Project 1"))
    application objStore save(Project clone setName("Project 2"))

    response := get("/admin")

    projects := response page findElements(class == "project")
    assertEquals(2, projects size)
    assertEquals("Project 1", projects first allText)
    assertEquals("Project 2", projects last allText)
  )

  testIndexAfterAddingProjectsDisplaysProjectsWithNames := method (
    repo := GitRepository at(TempDirectory testDir directoryNamed("repo"))
    repo gitInit

    response := get("/admin")
    projectForm := response page at("projectForm")

    projectForm input("name") set("Project 1")
    projectForm input("uri") set(repo directory path)
    submit(projectForm)

    response := get("/admin")

    projects := response page findElements(class == "project")
    assertEquals(1, projects size)
    assertEquals(repo directory path, 
                 GitRepository at(application projectDirectory directoryNamed("Project 1")) originUrl)
  )
)
