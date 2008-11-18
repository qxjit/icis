BuildProcess := Object clone do(
  newSlot("command")
  newSlot("started", false)
  newSlot("file", nil)
  newSlot("exitStatus", nil)

  start := method(
    self systemCall := SystemCall clone
    if(command, 
        setFile(File clone setPath(command)) @@build
        , 
        setExitStatus(1))
    setStarted(true)
  )

  build := method(
    file popen
    file close
    setExitStatus(file exitStatus)
  )

  isRunning := method(started and exitStatus isNil)
  isSuccessful := method(isRunning not and exitStatus == 0)
)
