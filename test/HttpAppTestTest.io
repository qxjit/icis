Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  TestApp := Object clone do (
    newSlot("lastRequest", nil)
    newSlot("lastResponse", nil)
    handleRequest := method(request, response, lastRequest = request; lastResponse = response)
  )

  testGetCreatesRequestWithGetMethod := method (
    test := HttpAppTest clone setApplication(TestApp clone)
    test get("/")
    assertEquals("GET", test application lastRequest requestMethod)
  )

  testGetCreatesRequestWithPathAndUriSet := method (
    test := HttpAppTest clone setApplication(TestApp clone)
    test get("/somePath")
    assertEquals("/somePath", test application lastRequest path)
  )

  testGetReturnsResponsePassedToApplication := method (
    test := HttpAppTest clone setApplication(TestApp clone)
    response := test get("/")
    assertEquals(test application lastResponse, response)
  )
)
