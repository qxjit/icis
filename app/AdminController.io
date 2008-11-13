AdminController := Controller clone do (
  projects := List clone

  handleRequest := method(request, response,
    if (request requestMethod == "POST", 
      projects append(request parameters at("name"))
    )

    response body = renderer render("admin.html")
  )
)
