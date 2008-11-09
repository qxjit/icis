AdminController := Object clone do (
  handleRequest := method(request, response,
    response body = "<html><h1>Welcome to Icis - Admin</h1></html>"
  )
)
