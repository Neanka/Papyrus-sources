Scriptname PRKF_quest extends Quest

actor playerref
PRKFramework PRK

String Property sname Auto
String Property pluginname Auto
int Property iVersion Auto
int Property iFWNeededVersion Auto
int Property iPPOnLevelUp Auto
int Property iSPOnLevelUp Auto

Function setvariables()

EndFunction

Event OnQuestInit()
  setvariables()
  playerref = Game.GetPlayer()
  PRK = PRKFramework.GetInstance()
  RegisterForCustomEvent(PRK, "PRKFReady")
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
EndEvent

Event Actor.OnPlayerLoadGame(Actor aSender)

EndEvent

Event PRKFramework.PRKFReady(PRKFramework akSender, Var[] akArgs)
  DoMagic()
EndEvent

Function DoMagic()

EndFunction

bool Function CheckPlugin()
  return Game.IsPluginInstalled(pluginname) && PRK.checkVersion(iFWNeededVersion,sname)
EndFunction

Function AddPerks(FormList aFL)
  If(CheckPlugin())
    PRK.AddPerks(aFL)
  EndIf
EndFunction

Function AddPerksToStart(FormList aFL)
  If(CheckPlugin())
    PRK.AddPerksToStart(aFL)
  EndIf
EndFunction

Function AddSkills(FormList aFL)
  If(CheckPlugin())
    PRK.AddSkills(aFL)
  EndIf
EndFunction

Function AddSkillsToStart(FormList aFL)
  If(CheckPlugin())
    PRK.AddSkillsToStart(aFL)
  EndIf
EndFunction

Function AddPPOnLvlUp()
  If(CheckPlugin())
    PRK.AddPPOnLevelUp(iPPOnLevelUp)
  EndIf
EndFunction

Function AddSPOnLvlUp()
  If(CheckPlugin())
    PRK.AddSPOnLevelUp(iSPOnLevelUp)
  EndIf
EndFunction
