;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname FOC:Fragments:TopicInfos:TIF_FCKentPontusDialogue_02020636 Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Good stage
FCM01.SetStage(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Int Property pCaps001 Auto Const

MiscObject Property Caps001 Auto Const

Weapon Property PontusLaserRifle Auto Const

Quest Property FCM01 Auto Const
