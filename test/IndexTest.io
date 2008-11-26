Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  testIndexDisplaysBanner := method (
    response := get("/")
    assertEquals("Welcome to Icis", response page at("title") allText)
  )

  testIndexDisplaysProjects := method (
    objStore save(Project clone setName("Project 1"))
    objStore save(Project clone setName("Project 2"))
    
    response := get("/")

    assertEquals(2, response page findElements(class == "project") size)
  )

  testIndexDisplaysBuildsForEachProject := method (
    objStore save(p1 := Project clone setName("Project 1"))
    objStore save(p1 newBuild)
    objStore save(p1 newBuild)
    objStore save(p2 := Project clone setName("Project 2"))
    objStore save(p2 newBuild)
    
    response := get("/")

    projectElements := response page findElements(class == "project")
    assertEquals(2, projectElements first findElements(class == "build") size)
    assertEquals(1, projectElements second findElements(class == "build") size)
  )

  testIndexReflectsChangesInProjectsMadeBetweenRequests := method (
    objStore save(p1 := Project clone setName("Project 1"))
    
    response := get("/")
    assertEquals(0, response page findElements(class == "build") size)

    objStore save(p1 newBuild)

    response := get("/")
    assertEquals(1, response page findElements(class == "build") size)
  )
)
