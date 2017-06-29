Scriptname PRKF_VanillaPerksController extends Quest

actor playerref
PRKFramework PRK

String Property sname = "Vanilla Perks" AutoReadOnly
int Property iVersion = 1 AutoReadOnly
int Property iFWNeedeVersion = 1 AutoReadOnly

Event OnQuestInit()
  playerref = Game.GetPlayer()
  PRK = PRKFramework.GetInstance()
  RegisterForCustomEvent(PRK, "PRKFReady")
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  if PRK.isReady()
    DoMagic()
  endif
EndEvent

Event Actor.OnPlayerLoadGame(Actor aSender)

EndEvent

Event PRKFramework.PRKFReady(PRKFramework akSender, Var[] akArgs)
  DoMagic()
EndEvent

Function DoMagic()
  If(Game.IsPluginInstalled("PRKF_VanillaPerks.esp") && PRK.checkVersion(iFWNeedeVersion,sname))
    PRK.AddPerksToStart(Pvanilla_perks)
    PRK.AddPPOnLevelUp(1)
  EndIf
EndFunction

FormList Property Pvanilla_perks Auto Const Mandatory
