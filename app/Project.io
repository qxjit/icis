Project := Object clone do (
  newSlot("name")
  pSlots(name)

  all := method(
    projects := PDB root at("projects") 
    projects ifNil(PDB root atPut("projects", projects = list()))
    projects
  )

  save := method(
    PDB open
    all append(self)
    PDB sync
    PDB close
  )
)
