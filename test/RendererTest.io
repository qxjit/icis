Lobby doRelativeFile("TestHelper.io")

UnitTest clone do(
  testRendererReadsContentsOfFileInPath := method(
    TempDirectory testFile setContents("some crazy text")
    renderer := Renderer clone setDirectory(TempDirectory)
    assertEquals("some crazy text", renderer render(TempDirectory testFile name))
  )

  testRendererInterpolatesFileInContextOfTheCaller := method(
    TempDirectory testFile setContents("#{var1} #{var2}")
    var1 := "value 1"
    var2 := "value 2"

    renderer := Renderer clone setDirectory(TempDirectory)

    assertEquals("value 1 value 2", renderer render(TempDirectory testFile name))
  )
)
