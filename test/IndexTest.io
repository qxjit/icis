Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  testIndexDisplaysBanner := method (
    response := get("/")
    assertEquals("Welcome to Icis", response page at("title") allText)
  )
)
