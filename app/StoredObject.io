StoredObject := Object clone do (
  storedFields := method(
    args := call evalArgs
    args foreach(field, newSlot(field))
    self savedSlots := args
  )
)
