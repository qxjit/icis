IcisApp := Object clone do (
  handleRequest := method(request, response,
    controller := if (request path == "/", IndexController, AdminController)
    controller handleRequest(request, response)
  )
)
