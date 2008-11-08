UnitTest clone do (
  testIndexDisplaysBanner := method (
    #response = get "/"
    #assertEquals(true, response matchesRegex("<h1>Wecome to Icis</h1>"))
  )
)
