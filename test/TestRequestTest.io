Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testEveryTestRequestGetsItsOwnParameters := method (
    request1 := TestRequest clone
    request1 parameters atPut("param", "value")

    request2 := TestRequest clone
    assertEquals(nil, request2 parameters at("param"))
  )
)
