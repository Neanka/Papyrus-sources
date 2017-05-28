;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname FOC:Fragments:TopicInfos:TIF_FCR01_020206B4 Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_Begin
Function Fragment_Begin(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN AUTOCAST TYPE FOC:FOC_RadioScript
FOC:FOC_RadioScript kmyQuest = GetOwningQuest() as FOC:FOC_RadioScript
;END AUTOCAST
;BEGIN CODE
kmyquest.currentNews = 3
kmyquest.UpdateNews()
kmyquest.cyclesPlayed=0
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
