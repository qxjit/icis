TestResponse := Object clone do (
  newSlot("body")
  page := method (HTMLPage parse(body))
)
