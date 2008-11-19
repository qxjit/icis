LineItem := Object clone do (
  newSlot("name"); 
  savedSlots := list("name")
  == := method(other, id == other ifNonNilEval(id)) 
  != := method(other, id != other ifNonNilEval(id)) # for assertEquals
)
