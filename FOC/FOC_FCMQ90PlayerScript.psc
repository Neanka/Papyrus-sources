Scriptname FOC:FOC_FCMQ90PlayerScript extends ReferenceAlias

; Matches up to FCMQ90 in the CK.
Quest Property FCMQ90 Auto

Bool Property SPECIALDONE = False Auto

Armor Property Pipboy Auto

Event OnAliasInit()
	AddInventoryEventFilter(Pipboy)
EndEvent