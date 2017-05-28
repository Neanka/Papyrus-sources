Scriptname foc:FOC_FactionArmor extends ObjectReference Const
{The script that controls faction armor, functions by assigning the PC to a hidden faction which is allied to the faction the armor belongs to on equip, removes the player on unequip.

Uses three properties, one for the faction to add/remove the PC from and two for the messages that displays onequip/unequip.}

Faction Property FactionAlly Auto Const

Message Property EquipMessage Auto Const

Message Property UnequipMessage Auto Const

Event OnEquipped(Actor akActor)
	akActor.AddToFaction(FactionAlly)
		if akActor == Game.GetPlayer()
			EquipMessage.Show()
		EndIf
EndEvent

Event OnUnequipped(Actor akActor)
	akActor.RemoveFromFaction(FactionAlly)
		if akActor == Game.GetPlayer()
			UnequipMessage.Show()
		EndIf
EndEvent