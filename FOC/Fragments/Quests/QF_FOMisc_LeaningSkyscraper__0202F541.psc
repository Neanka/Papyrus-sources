;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname foc:Fragments:Quests:QF_FOMisc_LeaningSkyscraper__0202F541 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
LSPGElevatorDoor.SetOpen()
utility.wait(1)
LSPGElevatorDoor.SetOpen(false)
utility.wait(1)
Self.SetCurrentStageID(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
Self.SetCurrentStageID(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property LSPGElevatorDoor Auto Const

Door Property ElevatorDoorLoop Auto Const

Quest Property LSElevatorLoopQuest Auto Const
