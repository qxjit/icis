GitRepository := Object clone do (
  newSlot("directory")

  gitInit := method(
    directory create
    System system("cd " .. directory path .. " && git init -q")
  )
)
