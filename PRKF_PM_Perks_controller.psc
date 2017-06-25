Scriptname PRKF_PM_Perks_controller extends Quest

actor playerref
PRKFramework PRK

String Property sname = "PM Perks" AutoReadOnly
int Property iVersion = 1 AutoReadOnly
int Property iFWNeedeVersion = 1 AutoReadOnly

Event OnQuestInit()
  playerref = Game.GetPlayer()
  PRK = PRKFramework.GetInstance()
  PRK.checkVersion(iFWNeedeVersion,sname)
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  RegisterForCustomEvent(PRK, "PRKFReady")
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)

EndEvent

Event PRKFramework.PRKFReady(PRKFramework akSender, Var[] akArgs)
;  PRK.IntenseTrainingPerk(PPM_Intense_training01.GetFormID())
  PRK.UniquePerks(PPM_Intense_training01.GetFormID(),PPM_No_Weaknesses01.GetFormID(),PPM_Almost_Perfect01.GetFormID())
  PRK.AddPerks(PPM_perks)
  PRK.AddPPOnLevelUp(1)
EndEvent

FormList Property PPM_perks Auto Const Mandatory

Perk Property PPM_Intense_training01 Auto Const Mandatory

Perk Property PPM_Almost_Perfect01 Auto Const Mandatory

Perk Property PPM_No_Weaknesses01 Auto Const Mandatory
