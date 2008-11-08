Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  TestApp := Object clone do (
    newSlot("lastRequest", nil)
    handleRequest := method(request, response, lastRequest = request)
  )

  testGetCreatesRequestWithGetMethod := method (
    test := HttpAppTest clone setApplication(TestApp clone)
    response := test get("/")
    assertEquals("GET", test application lastRequest requestMethod)
  )

  testGetCreatesRequestWithPathAndUriSet := method (
    test := HttpAppTest clone setApplication(TestApp clone)
    response := test get("/somePath")
    assertEquals("/somePath", test application lastRequest path)
    assertEquals("/somePath", test application lastRequest uri)
  )
)
