Project := StoredObject clone do (
  storedFields("name", "url", "buildCommand")

  newBuild := method(Build clone setProject(self))
)
