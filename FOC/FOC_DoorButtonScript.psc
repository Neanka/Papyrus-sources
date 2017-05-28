Scriptname FOC:FOC_DoorButtonScript extends ObjectReference

 ObjectReference Property MyDoor Auto
ObjectReference Property MySecondDoor Auto

Event OnActivate(ObjectReference akActionRef)
   int openState = MyDoor.GetOpenState()
   int openStateTwo = MySecondDoor.GetOpenState()
   If (openState == 3)
      MyDoor.SetOpen(true)
     EndIf
   If(openStateTwo == 3)
       MySecondDoor.SetOpen(true)
      EndIf
EndEvent 