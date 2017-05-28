;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname FOC:Fragments:Terminals:TERM_1CasKentMuseumSecurityT_0201B640 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
ExhibitDoor.unlock()
ExhibitDoor.SetOpen(true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property ExhibitDoor Auto Const
