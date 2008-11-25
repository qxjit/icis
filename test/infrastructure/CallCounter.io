CallCounter := Object clone do (
  with := method(object, methodName, self clone countCallsTo(object, methodName))
  callCount := 0

  countCallsTo := method(object, methodName,
    originalMethod := object getSlot(methodName) clone setIsActivatable(false)
    object setSlot(methodName, block(
      callCount = callCount + 1
      originalMethod performOn(object, call sender, call message)
    ) setIsActivatable(true))
    self
  )
)
