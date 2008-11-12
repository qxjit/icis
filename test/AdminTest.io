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

  testIndexAfterAddingProjectsDisplaysProjectsWithNames := method (
    response := get("/admin")
    projectForm := response page at("projectForm")

    projectForm input("name") set("Project 1")
    submit(projectForm)

    projectForm input("name") set("Project 2")
    submit(projectForm)

    response := get("/admin")

    projects := response page findElements(class == "project")
    assertEquals(2, projects size)
    assertEquals("Project 1", projects first allText)
    assertEquals("Project 2", projects last allText)
  )
)
