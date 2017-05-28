Scriptname FOC:FOC_FCMQ90PassportScript extends ObjectReference

Quest Property FCMQ90 Auto Const

Bool Property IsSpecialDone = False Auto

Activator Property pPassport Auto

Event OnActivate(ObjectReference akActionRef)
	
	If akActionRef == Game.GetPlayer() && IsSpecialDone == False
		IsSpecialDone = True
		
		; Trigger SPECIAL Menu
		Game.ShowSPECIALMenu()

		; Removes passport from world
		self.Disable()

		;Progress FCMQ101 to stage 20
		FCMQ101.SetStage(20)
	EndIf
EndEvent
Quest Property FCMQ101 Auto Const
