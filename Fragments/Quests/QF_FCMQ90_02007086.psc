;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Quests:QF_FCMQ90_02007086 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
; Teleport player to motel room
Game.GetPlayer().MoveTo(pFCMQ100StartMarker)

; Setup player inventory

; Clear inventory
Game.GetPlayer().RemoveAllItems()

; Fill inventory
Game.GetPlayer().AddItem(pClothesMacCready, absilent=true)
Game.GetPlayer().EquipItem(pClothesMacCready, absilent=true)

; Autosave.
Game.RequestAutoSave()

SetStage(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
;SetStage(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property pClothesMacCready Auto Const

ObjectReference Property pFCMQ100StartMarker Auto Const

Armor Property pPipboyDusty Auto Const

Activator Property pPassport Auto Const

Activator Property pPassport Auto Const

Weather Property ClearWeather Auto Const
