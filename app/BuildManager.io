BuildManager := Object clone do (
  newSlot("application")
  newSlot("buildProcessProto", BuildProcess)

  updateProcesses := method(
    builds := objStore builds
    projects := objStore projects
    projects select(p, builds detect(b, p id == b projectId) not) foreach(project,
      buildProcessProto clone setCommand(project buildCommand) start
      objStore save(project newBuild setStatus(Build Status Running))
    )
  )

  objStore := method(application objStore)
)
