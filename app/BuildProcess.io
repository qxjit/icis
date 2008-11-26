BuildProcess := Object clone do(
  newSlot("project")
  newSlot("projectDirectory")
  newSlot("started", false)
  newSlot("isRunning", false)
  newSlot("error", nil)

  start := method(
    @@run
    setIsRunning(true)
  )

  run := method(
    error = try(
      repo := project newClonedRepositoryIn(projectDirectory)
      proc := ShellProcess clone setDirectory(repo directory) setCommand(project buildCommand)
      proc start whenDone isSuccessful ifFalse(
        Exception raise("build failed")
      )
    )
    setIsRunning(false)
  )

  isSuccessful := method(isRunning not and error isNil)
)
