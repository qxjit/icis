IndexController := Object clone do (
  handleRequest := method(request, response,
    response body = "<html><h1>Welcome to Icis</h1></html>"
  )
)
