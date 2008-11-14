AdminController := Controller clone do (
  projects := List clone

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
