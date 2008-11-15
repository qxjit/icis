Build := Object clone do(
  newSlot("command")

  start := method(
    self systemCall := SystemCall clone
    commandAndArgs := command split(" ")
    systemCall setCommand(commandAndArgs first)
    systemCall setArguments(commandAndArgs slice(1))
    systemCall @@run
    yield
    self
  )

  isRunning := method(systemCall isRunning)
  isSuccessful := method(isRunning not and systemCall returnCode == 0)
)
