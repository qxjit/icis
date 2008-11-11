Lobby doRelativeFile("TestHelper.io")

UnitTest clone do (
  testPageParsesHtmlPage := method (
    assertEquals("HTMLPage", 
                 TestResponse clone setBody("<html></html>") page type)
  )
)
