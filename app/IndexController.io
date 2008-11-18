IndexController := Controller clone do (
  handleRequest := method(request, response,
    response body = renderer render("index.html")
  )

  projects := method(objStore projects)
  buildsFor := method(project, 
    objStore builds select(b, b projectId == project id)
  )
)
