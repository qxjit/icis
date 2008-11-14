TestExtras := Object clone do (
  setIsActivatable(true)

  activate := method(
    call target clone do (
      ancestors unique map(type) foreach(ancestorType, 
        appendProto(getSlot("TestExtras") getSlot(ancestorType))
      )
    )
  )
     
  Directory := Object clone do (
    recursivelyRemove := method (
      name in(list(".", "..")) ifFalse(
        exists ifTrue(
          items foreach(TestExtras recursivelyRemove)
          remove)
      )
    )
  )
  
  File := Object clone do (recursivelyRemove := method(remove))
)
