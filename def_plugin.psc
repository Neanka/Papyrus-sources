Scriptname def_plugin extends Quest

actor playerref
Event OnQuestInit()
  playerref = Game.GetPlayer()
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  registercustomevents()
EndEvent

Function registercustomevents()
  RegisterForKey(84)
  RegisterForKey(89)
EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)
  registercustomevents()
EndEvent

Event OnKeyDown(int keyCode)
  If(keyCode == 84)
    def.showlevelupmenu()
  EndIf
  If(keyCode == 89)
    def.showsleepwaitmenu()
  EndIf
EndEvent
