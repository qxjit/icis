IcisApp := Object clone do (
  newSlot("projectDirectory", AppDirectory parentDirectory directoryNamed("projects"))

  objStore := method( 
    ObjectStore clone setPath(projectDirectory fileNamed("projects.sqlite") path)
  )

  handleRequest := method(request, response,
    controller := if (request path == "/", IndexController, AdminController) clone
    controller setApplication(self) handleRequest(request, response)
  )
)
