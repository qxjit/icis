Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  setUp := method (
    self TestApp := Object clone do (
      newSlot("lastRequest", nil)
      newSlot("lastResponse", nil)
      handleRequest := method(request, response, 
        lastRequest = request; lastResponse = response
        response body = "ok"
      )
    )
  )

  testGetCreatesRequestWithGetMethod := method (
    test := HttpAppTest clone setApplication(TestApp)
    test get("/")
    assertEquals("GET", TestApp lastRequest requestMethod)
  )

  testGetCreatesRequestWithPathAndUriSet := method (
    test := HttpAppTest clone setApplication(TestApp)
    test get("/somePath")
    assertEquals("/somePath", TestApp lastRequest path)
  )

  testGetReturnsResponsePassedToApplication := method (
    test := HttpAppTest clone setApplication(TestApp)
    response := test get("/")
    assertEquals(TestApp lastResponse, response)
  )

  testSubmitCreatesRequestWithRequestMethodOfForm := method (
    test := HttpAppTest clone setApplication(TestApp)
    form := Object clone do(requestMethod := "POST"; action := nil; parameters := nil)
    test submit(form)
    assertEquals("POST", TestApp lastRequest requestMethod)
  )

  testSubmitCreatesRequestWithPathEqualToActionOfForm := method (
    test := HttpAppTest clone setApplication(TestApp)
    form := Object clone do(action := "/doit"; requestMethod := nil; parameters := nil)
    test submit(form)
    assertEquals("/doit", TestApp lastRequest path)
  )

  testSubmitCreatesRequestWithParametersOfForm := method (
    test := HttpAppTest clone setApplication(TestApp)
    form := Object clone do(parameters := Map clone; requestMethod := nil; action := nil)
    form parameters atPut("key", "value")
    test submit(form)
    assertEquals(form parameters, TestApp lastRequest parameters)
  )

  testSubmitReturnsResponsePassedToApplication := method (
    test := HttpAppTest clone setApplication(TestApp)
    form := Object clone do(requestMethod := "POST"; action := nil; parameters := nil)
    response := test submit(form)
    assertEquals(TestApp lastResponse, response)
  )
)
