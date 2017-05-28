Scriptname DEF_MCM_BASE_QUEST extends Quest

actor playerref

Event OnInit()
  playerref = Game.GetPlayer()
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  registerevents()
  Debug.Notification("MCM_Controller started")
EndEvent

Event Actor.OnPlayerLoadGame(Actor aSender)
  registerevents()
EndEvent

Function registerevents()
  RegisterForExternalEvent("mcm_test", "onmcmtest")
EndFunction

Function onmcmtest()
  Debug.Messagebox("mcmtest")
  Debug.Trace("MCMTEST")

EndFunction
