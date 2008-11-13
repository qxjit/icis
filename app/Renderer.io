Renderer := Object clone do (
  newSlot("directory")
  
  render := method(filename, 
    directory fileNamed(filename) contents doMessage(message(interpolate), 
                                                     call sender)
  )
)
