;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Quests:QF_FCMQ100_020250B3 Extends Quest Hidden Const

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

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
; Applies player restrictions
Game.GetPlayer().AddItem(pFCMQ100PotionPrePipBoy, abSilent=True)
Game.GetPlayer().EquipItem(pFCMQ100PotionPrePipBoy, abSilent=True)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property FCMQ101StartLocationMarker Auto Const

Quest Property pFCMQ100StartLocationMarker Auto Const

ObjectReference Property pFCMQ100StartMarker Auto Const

Armor Property pClothesMacCready Auto Const

MagicEffect Property FCMQ100PrePibBoyPlayerControls Auto Const
{Disables player controls.}

Potion Property pFCMQ100PotionPrePipBoy Auto Const
