AdminController := Object clone do (
  projects := List clone

  handleRequest := method(request, response,
    if (request requestMethod == "POST", 
      projects append(request parameters at("name"))
    )

    response body = """
<html>
  <body>
    <h1 id="title">Welcome to Icis - Admin</h1>
    <form id="projectForm" method="post">
      Name: <input type="text" name="name"/>
      <input type="submit" name="submit" value="Create Project"/>
    </form>
    #{projectDivs}
  </body>
</html>
""" interpolate
  )

  projectDivs := method(
    projects map(name, "<div class='project'>#{name}</div>" interpolate) join
  )
)
