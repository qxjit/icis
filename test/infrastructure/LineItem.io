LineItem := Object clone do (
  newSlot("name"); 
  newSlot("orderId");
  savedSlots := list("name", "orderId")
  == := method(other, id == other ?id) 
  != := method(other, id != other ?id) # for assertEquals
)
