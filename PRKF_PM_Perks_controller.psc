Scriptname PRKF_PM_Perks_controller extends Quest

actor playerref
PRKFramework PRK

String Property sname = "PM Perks" AutoReadOnly
int Property iVersion = 1 AutoReadOnly
int Property iFWNeedeVersion = 1 AutoReadOnly

Event OnQuestInit()
  playerref = Game.GetPlayer()
  PRK = PRKFramework.GetInstance()
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  RegisterForCustomEvent(PRK, "PRKFReady")
  if PRK.isReady()
    DoMagic()
  endif
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)

EndEvent

Event PRKFramework.PRKFReady(PRKFramework akSender, Var[] akArgs)
  DoMagic()
EndEvent

Function DoMagic()
  If(Game.IsPluginInstalled("PRKF_PMPerks.esp") && PRK.checkVersion(iFWNeedeVersion,sname))
    PRK.UniquePerks(PPM_Intense_training01.GetFormID(),PPM_No_Weaknesses01.GetFormID(),PPM_Almost_Perfect01.GetFormID())
    PRK.AddPerks(PPM_perks)
    PRK.AddPPOnLevelUp(1)
  EndIf
EndFunction

FormList Property PPM_perks Auto Const Mandatory

Perk Property PPM_Intense_training01 Auto Const Mandatory

Perk Property PPM_Almost_Perfect01 Auto Const Mandatory

Perk Property PPM_No_Weaknesses01 Auto Const Mandatory
