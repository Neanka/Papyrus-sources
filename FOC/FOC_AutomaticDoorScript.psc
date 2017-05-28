Scriptname FOC:FOC_AutomaticDoorScript extends ObjectReference Const

Event OnOpen(ObjectReference akActionref)  
  StartTimer(5) ; Put time here  
EndEvent  
  
Event OnTimer(int aiTimerID)  
  Self.SetOpen(False)  
EndEvent   