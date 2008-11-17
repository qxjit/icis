BuildProcess := Object clone do(
  newSlot("command")
  newSlot("started", false)
  newSlot("file", nil)
  newSlot("returnCode", nil)

  start := method(
    self systemCall := SystemCall clone
    setFile(File clone setPath(command)) @@build
    setStarted(true)
  )

  build := method(
    file popen
    file close
  )

  isRunning := method(started and file exitStatus isNil)
  isSuccessful := method(isRunning not and file exitStatus == 0)
)
