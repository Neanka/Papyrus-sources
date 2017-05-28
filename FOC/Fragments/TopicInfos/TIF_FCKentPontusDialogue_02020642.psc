;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname FOC:Fragments:TopicInfos:TIF_FCKentPontusDialogue_02020642 Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Tried to lie
FCM01.SetStage(25)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property FCM01 Auto Const

Weapon Property PontuLaserRifle Auto Const

MiscObject Property pCaps001 Auto Const
