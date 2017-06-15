Scriptname PRKFramework extends Quest

actor playerref

int Property iVersion = 1 AutoReadOnly

Event OnQuestInit()
  playerref = Game.GetPlayer()
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  registercustomevents()
EndEvent

CustomEvent PRKFReady

Function registercustomevents()
  Pperk_list.Revert()
  RegisterForKey(103)
  RegisterForKey(104)
  RegisterForKey(100)
  RegisterForKey(101)
  RegisterForExternalEvent("LevelUp::Ready", "OnLevelUpReady")
  RegisterForMenuOpenCloseEvent("LevelUpMenu")
  FillUnlearnedPerks(Pperk_list)
  SendPRKFReadyEvent()
EndFunction

Function SendPRKFReadyEvent()
	Var[] args = new Var[0]
	sendCustomEvent("PRKFReady", args)
EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)
  registercustomevents()
EndEvent

bool Function checkVersion(int aiReqVersion, String asName)
  If (GetVersion() != aiReqVersion)
    Debug.MessageBox(asName + " required PRKFramework version "+aiReqVersion)
    return false
  Else
    return true
  EndIf
EndFunction

int Function GetVersion()
  return iVersion
EndFunction

PRKFramework Function GetInstance() global
    If (Game.IsPluginInstalled("PRKFramework.esm"))
        return Game.GetFormFromFile(0xF99, "PRKFramework.esm") as PRKFramework
    Else
        return None
    EndIf
EndFunction

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
  if (asMenuName== "LevelUpMenu")
      if (abOpening)
      endif
  endif
endEvent

Event OnKeyDown(int keyCode)
  If(keyCode == 103)
    Debug.Notification("added 50 exp")
    Debug.Notification(def.addexp(50))
  Debug.Trace(Game.GetInstalledPlugins())
  EndIf
  If(keyCode == 104)
    OnLevelUpReady()
  EndIf
  If(keyCode == 100)
    def.exe("player.addperk 4d869")
    FillUnlearnedPerks(Pperk_list)
  EndIf
  If(keyCode == 101)
    def.exe("player.addperk 65df5")
    FillUnlearnedPerks(Pperk_list)
  EndIf
EndEvent

Function OnLevelUpReady()
  If (def.SetLVLUPVars(Punlearned_perks,Pskills_list,PSkillPoints,PPerkPoints,Game.GetPlayerLevel()))
    def.openmenu("levelupmenu")
  EndIf
EndFunction

Function FillUnlearnedPerks(FormList PerkList)
  Punlearned_perks.Revert()
  int i = 0
  While i < PerkList.GetSize()
    Perk tempperk = GetAvailablePerk(PerkList.GetAt(i) as Perk)
    If(tempperk)
      Punlearned_perks.AddForm(tempperk)
    EndIf
  i += 1
  EndWhile
EndFunction

Perk Function GetAvailablePerk(Perk aPerk)
  int i = 0
  Perk tempperk = aPerk
  While i<aPerk.GetNumRanks()
    If !playerref.HasPerk(tempperk)
      return tempperk
    EndIf
    tempperk = tempperk.GetNextPerk()
    i += 1
  EndWhile
  return None
EndFunction

Function AddPerks(FormList afFL)
  int i = 0
  While i < afFL.GetSize()
    Pperk_list.AddForm(afFL.GetAt(i))
  i += 1
  EndWhile
  FillUnlearnedPerks(Pperk_list)
EndFunction

Group FLs
  FormList Property Pperk_list Auto Const Mandatory
  FormList Property Pskills_list Auto Const Mandatory
  FormList Property Punlearned_perks Auto Const Mandatory
EndGroup

ActorValue Property PPerkPoints Auto Const Mandatory
ActorValue Property PSkillPoints Auto Const Mandatory
