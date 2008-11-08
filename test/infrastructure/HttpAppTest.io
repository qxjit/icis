HttpAppTest := UnitTest clone do (
  newSlot("application", nil)

  get := method(path, 
    request  := HttpRequest clone setRequestMethod("GET") setPath(path) setUri(path)
    response := HttpResponse clone
    application handleRequest(request, response)
    response
  )
)
