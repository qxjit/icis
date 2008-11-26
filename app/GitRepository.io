GitRepository := Object clone do (
  newSlot("directory")

  at := method(directory, self clone setDirectory(directory))

  gitInit := method(
    directory createIfAbsent
    gitDo(directory, "init")
  )

  gitClone := method(masterUri,
    if(directory exists, return self)
    gitDo(directory parentDirectory, "clone", masterUri, directory name)
  )

  originUrl := method(
    originInfo := File clone popen(
      "cd '#{directory path}' && git remote show -n origin" interpolate
    ) readLines
    originInfo detect(matchesRegex("\\s*URL:\\s+.*")) afterSeq("URL:") strip
  )

  gitDo := method(
    arguments := call evalArgs
    directory := arguments removeFirst
    gitCommand := arguments removeFirst
    argumentsString := arguments map(s, "'" .. s .. "'") join(" ")

    command := "git #{gitCommand} #{argumentsString}" interpolate
    logCommand(command)

    proc := ShellProcess clone setDirectory(directory) setCommand(command) 
    (proc start whenDone isSuccessful ifFalse(
      Exception raise(command .. " failed in " .. directory path)
    ))

    self
  )

  logCommand := method(nil)
)
