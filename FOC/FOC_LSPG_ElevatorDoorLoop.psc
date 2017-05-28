Scriptname foc:FOC_LSPG_ElevatorDoorLoop extends ObjectReference Const

Event OnLoad()
    if GetOpenState() == 1
    SetOpen(false)
    Else
        SetOpen()
    Endif
Endevent

Event OnOpen(ObjectReference akActionRef)
    SetOpen(False)
EndEvent

Event OnClose(ObjectReference akActionRef)
    SetOpen()
EndEvent