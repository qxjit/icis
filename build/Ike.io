Ike := Object clone do (
  userRequestedTasks := method (
    tasks := System args slice(1)
    if (tasks isEmpty, tasks append("default"), tasks)
  )

  run := method (
    userRequestedTasks foreach(command, Ike doString(command))
  )
)
