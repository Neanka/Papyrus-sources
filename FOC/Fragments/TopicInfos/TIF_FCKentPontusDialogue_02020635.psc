;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname FOC:Fragments:TopicInfos:TIF_FCKentPontusDialogue_02020635 Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
FCM01.SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property FCM01 Auto Const
