SQLite3Adapter := SQLite3 clone do (
  exec := method(
    rows := resend
    error ifNonNil(Exception raise(error))
    rows 
  )
)
