BuildProcess := Object clone do(
  newSlot("command")
  newSlot("directory", Directory with(Directory currentWorkingDirectory))
  newSlot("started", false)
  newSlot("exitStatus", nil)

  init := method(
    resend
    self output := "" asMutable
  )

  start := method(
    self systemCall := SystemCall clone
    if(command, @@build, setExitStatus(1))
    setStarted(true)
  )

  build := method(
    file := File clone setPath("cd " .. directory path .. " && " .. command)
    # streamTo recalls open, which resets the flags as causes pclose
    # to never be called and we don't get an exit status
    #
    file open = nil 
    file popen
    file streamTo(Receiver clone setTarget(self))
    file close
    setExitStatus(file exitStatus)
  )

  Receiver := Object clone do (
    newSlot("target")
    write := method(s, target output appendSeq(s))
  )

  isRunning := method(started and exitStatus isNil)
  isSuccessful := method(isRunning not and exitStatus == 0)
)
