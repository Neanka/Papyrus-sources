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
  Debug.Notification("PRK READY")
  PRK.AddPerks(Pvanilla_perks)
  Debug.Trace(def.traceperk(Pdummyperk))
EndEvent

FormList Property Pvanilla_perks Auto Const Mandatory

Perk Property Pdummyperk Auto Const Mandatory
