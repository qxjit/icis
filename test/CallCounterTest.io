UnitTest clone do (
  testCountsCallsMadeToMethod := method(
    testObject := Object clone do(testMethod := method)
    counter := CallCounter with(testObject, "testMethod")
    assertEquals(0, counter callCount)
    testObject testMethod
    assertEquals(1, counter callCount)
    testObject testMethod
    assertEquals(2, counter callCount)
  )

  testOriginalMethodIsCalledWithCorrectArgsAndSelf := method(
    testObject := Object clone do(
      testMethod := method(call evalArgs prepend(self))
    )
    CallCounter with(testObject, "testMethod")

    assertEquals(list(testObject, 1, 2), testObject testMethod(1, 2))
  )

  testOriginalMethodObjectIsLeftInWorkingOrderForOtherObjects := method(
    testProto := Object clone do(testMethod := method(call evalArgs))
    testObject := testProto clone
    CallCounter with(testObject, "testMethod")
    testObject testMethod
    assertEquals(list(1, 2), testProto clone testMethod(1, 2))
  )

  testOriginalMethodIsCallWithsArgsEvaluatableFromOriginalCalled := method(
    testObject := Object clone do(testMethod := method(call evalArgs))
    CallCounter with(testObject, "testMethod")
    testLocal := "local"
    assertEquals(list("local"), testObject testMethod(testLocal))
  )
)
