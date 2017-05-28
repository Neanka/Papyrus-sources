;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname FOC:Fragments:Quests:QF_FCMQ101_02037804 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
; CharGen over!  Back to standard HUD mode
Game.SetCharGenHUDMode(0)

SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
SetObjectiveCompleted(10)

Utility.Wait(0.2)

Game.RequestAutosave()

pAssassin.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0050_Item_00
Function Fragment_Stage_0050_Item_00()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0055_Item_00
Function Fragment_Stage_0055_Item_00()
;BEGIN CODE
SetObjectiveCompleted(50)
SetObjectiveDisplayed(55)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0100_Item_00
Function Fragment_Stage_0100_Item_00()
;BEGIN CODE
SetObjectiveCompleted(50)
SetObjectiveCompleted(55)
RamBart.Enable()

Utility.Wait(0.5)

SetStage(105)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0105_Item_00
Function Fragment_Stage_0105_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(105)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0150_Item_00
Function Fragment_Stage_0150_Item_00()
;BEGIN CODE
SetObjectiveCompleted(50)
SetObjectiveCompleted(55)
SetObjectiveCompleted(105)
SetObjectiveDisplayed(150)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property pCaps001 Auto Const

Actor Property p1Cas_AssassinDoorKicker Auto Const

Actor Property pAssassin Auto Const

ObjectReference Property p1CasAssassinDoorKicker Auto Const

ReferenceAlias Property Alias_KentAssassin Auto Const Mandatory

Actor Property KentAssassinProperty Auto Const

Actor Property NCRGreeter Auto Const

Actor Property RamBart Auto Const
