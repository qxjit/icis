AdminController := Object clone do (
  projectName := nil
  handleRequest := method(request, response,
    if (request requestMethod == "POST", 
      projectName = request parameters at("name")
    )

    response body = """
<html>
  <body>
    <h1 id="title">Welcome to Icis - Admin</h1>
    <form id="projectForm" method="post">
      Name: <input type="text" name="name"/>
      <input type="submit" name="submit" value="Create Project"/>
    </form>
    <div class="project">#{projectName}</div>
  </body>
</html>
""" interpolate
  )
)
