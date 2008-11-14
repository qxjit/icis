GitRepository := Object clone do (
  newSlot("directory")

  at := method(directory, self clone setDirectory(directory))

  gitInit := method(
    directory createIfAbsent
    gitDo(directory, "init")
  )

  gitClone := method(masterUri,
    gitDo(directory parentDirectory, "clone", masterUri, directory name)
  )

  gitDo := method(
    arguments := call evalArgs
    directory := arguments removeFirst
    gitCommand := arguments removeFirst

    command := "cd #{directory path} && git #{gitCommand} -q #{arguments join(\" \")}" interpolate
    logCommand(command)
    System system(command)
  )

  logCommand := method(nil)
)
