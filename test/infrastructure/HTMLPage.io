HTMLPage := Object clone do (
  newSlot("root", nil)

  parse := method(htmlAsString, 
    HTMLPage clone setRoot(Parser clone elementForString(htmlAsString))
  )

  at := method(requestedId, root at(requestedId))

  Element := SGMLElement clone do (
    at := method(requestedId, 
      if(attributes at("id") == requestedId, return self)
      subitems foreach(at(requestedId) returnIfNonNil)
    )

    allInputs     := method(elementsWithName("input"))
    inputName     := method(attributes at("name"))
    action        := method(attributes at("action"))
    requestMethod := method(attributes at("method") asMutable uppercase)
    set           := method(value, self value := value)
    value         := ""

    input := method(name, 
      input := allInputs detect(inputName == name)
      input ifNil(Exception raise("No Input With Name " .. name))
    )

    parameters := method(
      parameters := Map clone
      allInputs foreach(input, parameters atPut(input inputName, input value))
    )
  )

  Parser := SGMLParser clone
  Parser elementProto = Element 
)
