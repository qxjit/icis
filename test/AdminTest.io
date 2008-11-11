Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  testIndexDisplaysAdminBanner := method (
    response := get("/admin")
    assertEquals("Welcome to Icis - Admin", response page at("title") allText)
  )

  testIndexAfterAddingProjectDisplaysProjectWithName := method (
    response := get("/admin")
    projectForm := response page at("projectForm")
    projectForm input("name") set("My Project Name")
    submit(projectForm)
    response := get("/admin")

    projects := response page findElements(class == "project")
    assertEquals(1, projects size)
    assertEquals("My Project Name", projects first allText)
  )
)
