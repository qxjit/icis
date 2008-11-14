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

    command := "cd '#{directory path}' && git #{gitCommand} #{argumentsString} > /dev/null 2>&1" interpolate
    logCommand(command)
    (System system(command) == 0) ifFalse(Exception raise(command .. " failed"))
  )

  logCommand := method(nil)
)
