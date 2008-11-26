ShellProcess := Object clone do(
  newSlot("command")
  newSlot("directory", Directory with(Directory currentWorkingDirectory))
  newSlot("started", false)
  newSlot("exitStatus", nil)

  init := method(
    resend
    self output := "" asMutable
    self futureSelf := nil
  )

  start := method(
    futureSelf = if(command, @run, setExitStatus(1))
    setStarted(true)
  )

  run := method(
    file := File clone setPath("cd '" .. directory path .. "' && " .. command .. " 2>&1")
    # streamTo recalls open, which resets the flags as causes pclose
    # to never be called and we don't get an exit status
    #
    file open = nil 
    file popen
    file streamTo(Receiver clone setOutput(output))
    file close
    setExitStatus(file exitStatus)
  )

  whenDone := method(futureSelf)

  Receiver := Object clone do (
    newSlot("output")
    write := method(s, output appendSeq(s))
  )

  isRunning := method(started and exitStatus isNil)
  isSuccessful := method(isRunning not and exitStatus == 0)
)
