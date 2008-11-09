Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  testIndexDisplaysBanner := method (
    response := get("/")
    assertEquals(true, response body matchesRegex(".*<h1>Welcome to Icis</h1>.*"))
  )
)
