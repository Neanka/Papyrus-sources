;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname FOC:Fragments:Quests:QF_FCMQ95_02015A49 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
; Teleport player to motel room
Game.GetPlayer().MoveTo(pFCMQ100StartMarker)

; Should fix sprinting?
Game.GetPlayer().ChangeAnimArchetype(AnimArchetypePlayer)

; Sets weather
ClearWeather.SetActive(true)

; Setup player inventory

; Clear inventory
Game.GetPlayer().RemoveAllItems()

;allow time to advance
TimeScale.SetValueInt(20)

; Fill inventory
Game.GetPlayer().AddItem(pPipboy, absilent=true)
Game.GetPlayer().EquipItem(pPipboy, absilent=true)
Game.GetPlayer().AddItem(pClothesMacCready, absilent=true)
Game.GetPlayer().EquipItem(pClothesMacCready, absilent=true)

; Autosave.
Game.RequestAutoSave()

;Full  HUD Framework
Game.SetCharGenHUDMode(0)

SetStage(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
FCMQ101.SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property pFCMQ100StartMarker Auto Const

Armor Property pClothesMacCready Auto Const

Armor Property pPipboyDusty Auto Const

Armor Property pPipboy Auto Const

GlobalVariable Property TimeScale Auto Const

Quest Property FCMQ101 Auto Const

Quest Property Tutorial Auto Const

Weather Property ClearWeather Auto Const

Keyword Property AnimArchetypePlayer Auto Const
