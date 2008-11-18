Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testBuildCanBeAssociatedWithAProject := method(
    project := Project clone
    project id := "10"
    build := Build clone setProject(project)
    assertEquals("10", build projectId)
  )

  testBuildCanBeMarkedAsInStatuses := method(
    Build Status slotNames remove("type") foreach (status,
      assertEquals(Build Status getSlot(status),
                   Build clone doString("markAs" .. status) status)
    )
  )
)
