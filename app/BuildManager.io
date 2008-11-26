BuildManager := Object clone do (
  newSlot("application")
  newSlot("buildProcessProto", BuildProcess)

  updateProcesses := method(
    projects := objStore projects
    projects select(builds isEmpty) foreach(project,
      buildProcessProto clone setCommand(project buildCommand) start
      objStore save(project newBuild markAsRunning)
    )
  )

  run := method(loop(
    wait(1)
    updateProcesses
  ))

  objStore := method(application objStore)
)
