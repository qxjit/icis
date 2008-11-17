Build := StoredObject clone do(
  storedFields("status", "projectId")

  Status := Object clone do (
    Running := "Running"
    Failed := "Failed"
    Succeeded := "Succeeded"
  )

  setProject := method(project, setProjectId(project id))
)
