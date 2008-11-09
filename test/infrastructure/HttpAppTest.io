HttpAppTest := UnitTest clone do (
  newSlot("application", nil)

  get := method(path, 
    request  := TestRequest clone setRequestMethod("GET") setPath(path)
    response := TestResponse clone
    application handleRequest(request, response)
    response
  )
)
