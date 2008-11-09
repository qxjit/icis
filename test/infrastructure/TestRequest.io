TestRequest := Object clone do (
  newSlot("parameters", nil)
  newSlot("requestMethod", "GET")
  newSlot("path")

  init := method(parameters = Map clone)
)
