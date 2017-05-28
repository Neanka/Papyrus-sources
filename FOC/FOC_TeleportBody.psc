Scriptname foc:FOC_TeleportBody extends Actor Const

ObjectReference Property HoldingCellMarker Auto Const
Actor Property Smith Auto Const
Sound Property WildWastelandSound Auto Const

Event OnDeath(Actor akKiller)
	Utility.Wait(0.0)
       WildWastelandSound.Play(Game.GetPlayer())
	Smith.Disable(true)
EndEvent

