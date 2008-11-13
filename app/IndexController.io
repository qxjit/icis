IndexController := Controller clone do (
  handleRequest := method(request, response,
    response body = renderer render("index.html")
  )
)
