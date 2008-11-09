IcisApp := Object clone do (
  handleRequest := method(request, response,
    controller := if (request uri == "/", IndexController, AdminController)
    controller handleRequest(request, response)
  )
)
