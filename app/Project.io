Project := StoredObject clone do (
  storedFields("name", "url", "buildCommand")
  newSlot("gitRepositoryProto", GitRepository)
  associations := list("builds")

  newBuild := method(Build clone setProject(self))

  newClonedRepositoryIn := method(directory,
    repo := gitRepositoryProto clone setDirectory(
      directory directoryNamed(name)
    ) 
    repo gitClone(url)
  )
)
