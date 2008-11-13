Lobby doRelativeFile("TestHelper.io")

UnitTest clone do(
  testRendererReadsContentsOfFileInPath := method(
    TempDirectory fileNamed(call message name) setContents("some crazy text")
    renderer := Renderer clone setDirectory(TempDirectory)
    assertEquals("some crazy text", renderer render(call message name))
  )

  testRendererInterpolatesFileInContextOfTheCaller := method(
    TempDirectory fileNamed(call message name) setContents("#{var1} #{var2}")
    var1 := "value 1"
    var2 := "value 2"

    renderer := Renderer clone setDirectory(TempDirectory)

    assertEquals("value 1 value 2", renderer render(call message name))
  )
)
