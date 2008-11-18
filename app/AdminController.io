AdminController := Controller clone do (
  projects := method(objStore projects)

  handleRequest := method(request, response,
    if (request requestMethod == "POST", 
      project := Project clone setName(request parameters at("name")) \
                               setUrl(request parameters at("uri")) \
                               setBuildCommand(request parameters at("buildCommand"))

      objStore save(project)
    )

    response body = renderer render("admin.html")
  )
)
