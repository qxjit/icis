Lobby doRelativeFile("TestHelper.io")

IcisAppTest clone do (
  testIndexDisplaysAdminBanner := method (
    response := get("/admin")
    assertEquals(true, response body matchesRegex(".*<h1>Welcome to Icis - Admin</h1>.*"))
  )
)
