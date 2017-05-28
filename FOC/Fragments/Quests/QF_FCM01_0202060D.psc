;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname FOC:Fragments:Quests:QF_FCM01_0202060D Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0025_Item_00
Function Fragment_Stage_0025_Item_00()
;BEGIN CODE
SetObjectiveCompleted(20)

; Reward
Game.GetPlayer().AddItem(pCaps001, 200)
Game.GetPlayer().RemoveItem(pPontusLaserRifle)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0030_Item_00
Function Fragment_Stage_0030_Item_00()
;BEGIN CODE
SetObjectiveCompleted(20)

; Reward
Game.GetPlayer().AddItem(pCaps001, 200)
Game.GetPlayer().AddItem(pAmma10mm, 50)
Game.GetPlayer().RemoveItem(pPontusLaserRifle)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0035_Item_00
Function Fragment_Stage_0035_Item_00()
;BEGIN CODE
SetObjectiveCompleted(20)

; Reward
Game.GetPlayer().AddItem(pCaps001, 100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property pCaps001 Auto Const

Ammo Property pAmma10mm Auto Const

Weapon Property pPontusLaserRifle Auto Const
