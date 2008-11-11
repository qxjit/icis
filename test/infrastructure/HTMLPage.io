HTMLPage := SGMLElement clone do (
  parse := method(htmlAsString, Parser clone elementForString(htmlAsString))

  at := method(requestedId,
    if (attributes at("id") == requestedId, return self)
    subitems foreach(at(requestedId) returnIfNonNil)
  )

  allInputs     := method(elementsWithName("input"))
  inputName     := method(attributes at("name"))
  action        := method(attributes at("action"))
  set           := method(value, self value := value)
  value         := ""
  requestMethod := method(
    attributes at("method") ifNilEval("GET") asMutable uppercase
  )

  input := method(name, 
    input := allInputs detect(inputName == name)
    input ifNil(Exception raise("No Input With Name " .. name))
  )

  parameters := method(
    parameters := Map clone
    allInputs foreach(input, parameters atPut(input inputName, input value))
  )

  findElements := method(
    findElementsByPredicateInContext(call message arguments first, call sender)
  )

  findElementsByPredicateInContext := method(predicate, context,
    elements       := call evalArgAt(2) ifNilEval(List clone)

    predicateContext := context clone
    predicateContext setSlot(predicate name, attributes at(predicate name))

    if(predicateContext doMessage(predicate), elements append(self))
    subitems foreach(
      findElementsByPredicateInContext(predicate, context, elements)
    )
    return elements
  )
)
HTMLPage Parser := SGMLParser clone
HTMLPage Parser elementProto = HTMLPage
