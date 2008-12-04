SQLite3Adapter := SQLite3 clone do (
  open := method(
    if(isOpen, self, resend)
  )

  exec := method(
    rows := resend
    error ifNonNil(Exception raise(error))
    rows 
  )
)
