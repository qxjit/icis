Controller := Object clone do (
  newSlot("application")
  renderer := Renderer clone setDirectory(AppDirectory)
  lazySlot("objStore", application objStore)
)
