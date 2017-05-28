;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Quests:QF_FCMQ100_0302F0D5 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
Debug.Notification("Hello World!")

; Teleport player to motel room
Game.GetPlayer().MoveTo(pFCMQ100StartMarker)

; Setup player inventory

; Clear inventory
Game.GetPlayer().RemoveAllItems()

; Fill inventory
Game.GetPlayer().AddItem(pClothesMacCready, absilent=true)
Game.GetPlayer().EquipItem(pClothesMacCready, absilent=true)

SetStage(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
