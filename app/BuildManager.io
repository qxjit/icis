BuildManager := Object clone do (
  newSlot("application")
  newSlot("buildProcessProto", BuildProcess)

  updateProcesses := method(
    objStore := application objStore
    projects := objStore projects
    projects select(builds isEmpty) foreach(project,
      buildProcess := buildProcessProto clone 
      buildProcess setProject(project) \
                   setProjectDirectory(application projectDirectory) 
      buildProcess start
      objStore save(project newBuild markAsRunning)
    )
  )

  run := method(loop(
    wait(1)
    updateProcesses
  ))
)
