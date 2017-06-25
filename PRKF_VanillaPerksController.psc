Scriptname PRKF_VanillaPerksController extends Quest

actor playerref
PRKFramework PRK

String Property sname = "Vanilla Perks" AutoReadOnly
int Property iVersion = 1 AutoReadOnly
int Property iFWNeedeVersion = 1 AutoReadOnly

Event OnQuestInit()
  playerref = Game.GetPlayer()
  PRK = PRKFramework.GetInstance()
  PRK.checkVersion(iFWNeedeVersion,sname)
  RegisterForCustomEvent(PRK, "PRKFReady")
EndEvent

Event PRKFramework.PRKFReady(PRKFramework akSender, Var[] akArgs)
  PRK.AddPerksToStart(Pvanilla_perks)
EndEvent

FormList Property Pvanilla_perks Auto Const Mandatory
