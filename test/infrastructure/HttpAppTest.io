HttpAppTest := UnitTest clone do (
  newSlot("application", nil)

  setUp := method(
    resend
    setApplication(application clone)
  )

  get := method(path, 
    request  := TestRequest clone setRequestMethod("GET") setPath(path)
    response := TestResponse clone
    application handleRequest(request, response)
    response
  )

  submit := method(form,
    request  := TestRequest clone \
                  setRequestMethod(form requestMethod) \
                  setPath(form action) \
                  setParameters(form parameters)
    response := TestResponse clone
    application handleRequest(request, response)
    response
  )
)
