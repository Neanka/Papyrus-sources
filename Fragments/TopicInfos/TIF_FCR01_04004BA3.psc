;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:TopicInfos:TIF_FCR01_04004BA3 Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_Begin
Function Fragment_Begin(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN AUTOCAST TYPE FOCRadioScript
FOCRadioScript kmyQuest = GetOwningQuest() as FOCRadioScript
;END AUTOCAST
;BEGIN CODE
kmyquest.CurrentSong = 3
kmyquest.UpdateRadio()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
