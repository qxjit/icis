Controller := Object clone do (
  newSlot("application")
  renderer := Renderer clone setDirectory(AppDirectory)
  objStore := method(application objStore)
)
