AdminController := Controller clone do (
  projects := method(
    if(application projectDirectory exists,
      application projectDirectory directories map(name),
      list()
    )
  )

  handleRequest := method(request, response,
    if (request requestMethod == "POST", 
      projects append(name := request parameters at("name"))
      application projectDirectory createIfAbsent
      newRepo := GitRepository at(application projectDirectory directoryNamed(name))
      newRepo gitClone(request parameters at("uri"))
    )

    response body = renderer render("admin.html")
  )
)
