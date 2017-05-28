Scriptname foc:video_switch extends ObjectReference

ObjectReference Property somemarker Auto

Event OnActivate(ObjectReference akActionRef)	
	If(somemarker.IsEnabled())
		utility.wait(10)
		somemarker.disable()
	Else
		utility.wait(10)
		somemarker.enable()
	EndIf
EndEvent