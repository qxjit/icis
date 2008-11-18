Build := StoredObject clone do(
  storedFields("status", "projectId")

  Status := Object clone do (
    Running := "Running"
    Failed := "Failed"
    Succeeded := "Succeeded"
  )

  markAsFailed := method(setStatus(Status Failed))
  markAsRunning := method(setStatus(Status Running))
  markAsSucceeded := method(setStatus(Status Succeeded))

  setProject := method(project, setProjectId(project id))
)
