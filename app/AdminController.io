AdminController := Controller clone do (
  projects := method(objStore projects)

  handleRequest := method(request, response,
    application projectDirectory createIfAbsent

    if (request requestMethod == "POST", 
      project := Project clone setName(request parameters at("name")) \
                               setUrl(request parameters at("uri"))

      newRepo := GitRepository at(application projectDirectory directoryNamed(project name))
      newRepo gitClone(project url)
      objStore save(project)
    )

    response body = renderer render("admin.html")
  )
)
