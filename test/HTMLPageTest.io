Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testPageCanLocateElementsById := method (
    page := HTMLPage parse(
      "<html><body><div id='foo'>bar</div><div id='baz'></div></body></html>"
    )

    assertEquals("foo", page at("foo") attributes at("id"))
  )

  testPageCanLocateElementsByArbitraryAttribute := method (
    page := HTMLPage parse(
      "<body><div class='foo' id='bar'/><div class='foo' id='baz'/></body>"
    )
    
    expectedIds := List clone append("bar") append("baz")
    assertEquals(expectedIds, 
                 page findElements(class == "foo") map(attributes at("id")))
  )

  testPageCanLocateWithExpressionToBeEvaluatedInThisContext := method (
    page := HTMLPage parse("<div class='foo'/>")
    localVariable := "foo"
    assertEquals(1, page findElements(class == localVariable) size)
    assertFalse(hasLocalSlot("class"))
  )

  testTextFieldsWithinAFormCanBeFilledOutForSubmission := method (
    form := HTMLPage parse("""
      <form id="testForm">
        <div><input type="text" name="testTextField1"/></div>
        <div><input type="text" name="testTextField2"/></div>
      </form>
    """) at("testForm")

    form input("testTextField1") set("My Text")
    form input("testTextField2") set("Your Text")
    assertEquals("My Text", form parameters at("testTextField1"))
    assertEquals("Your Text", form parameters at("testTextField2"))
  )

  testFormFieldsThatAreNotFilledOutAreSubmittedAsBlank := method (
    form := HTMLPage parse("""
      <form id="testForm"><input type="text" name="testTextField1"/></form>
    """) at("testForm")

    assertEquals("", form parameters at("testTextField1"))
  )

  testAskingAFormForANonExistentInputFails := method (
    form := HTMLPage parse("<form id='testForm'></form>") at("testForm")
    assertRaisesException(form input("testTextField1"))
  )

  testActionOnFormReturnsActionAttribute := method (
    form := HTMLPage parse("<form id='id' action='/doit'></form>") at("id")
    assertEquals("/doit", form action)
  )

  testRequestMethodOnFormReturnsMethodAttribute := method (
    form := HTMLPage parse("<form id='id' method='post'></form>") at("id")
    assertEquals("POST", form requestMethod)
  )

  testRequestMethodOnFormDefaultsToGet := method (
    form := HTMLPage parse("<form id='id'></form>") at("id")
    assertEquals("GET", form requestMethod)
  )
)
