Scriptname PRKFramework extends Quest

actor playerref

int Property iVersion = 1 AutoReadOnly

FormList[] PerkList
FormList[] SkillsList
int Property BasePPToAdd = 0 AutoReadOnly
int PPToAdd
int Property BaseSPToAdd = 0 AutoReadOnly
int SPToAdd

Event OnQuestInit()
  playerref = Game.GetPlayer()
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  PerkList = new FormList[0]
  SkillsList = new FormList[0]
  registercustomevents()
EndEvent

CustomEvent PRKFReady

Function registercustomevents()
  RegisterForKey(103)
  RegisterForKey(104)
  RegisterForKey(100)
  RegisterForKey(101)
  RegisterForExternalEvent("LevelUp::Ready", "OnLevelUpReady")
  RegisterForMenuOpenCloseEvent("LevelUpMenu")
  PerkList.Clear()
  SkillsList.Clear()
  PPToAdd = BasePPToAdd
  SPToAdd = BaseSPToAdd
  SendPRKFReadyEvent()
EndFunction

Function SendPRKFReadyEvent()
  Utility.Wait(1)
  Debug.Notification("PRKF ready")
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
    If (Game.IsPluginInstalled("PRKFramework.esp"))
        return Game.GetFormFromFile(0xF99, "PRKFramework.esp") as PRKFramework
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
  EndIf
  If(keyCode == 104)
    OnLevelUpReady()
  EndIf
  If(keyCode == 100)
    def.tracesmth()
  EndIf
  If(keyCode == 101)
    ;Form stimpak = Game.GetForm(0x23736)
    ;playerref.AddItem(stimpak, 9)
    def.exe("hidemenu levelupmenu")
  EndIf
EndEvent

Function OnLevelUpReady()
;  Debug.MessageBox(APPerkID)
  If (def.SetLVLUPVars(PerkList,SkillsList,PSkillPoints,PPerkPoints))
    def.openmenu("levelupmenu")
  EndIf
EndFunction

Function AddPerks(FormList afFL)
  PerkList.Add(afFL)
EndFunction

Function AddPerksToStart(FormList afFL)
  PerkList.Insert(afFL,0)
EndFunction

Function AddSkills(FormList afFL)
  SkillsList.Add(afFL)
EndFunction

Function AddSkillsToStart(FormList afFL)
  SkillsList.Insert(afFL,0)
EndFunction

int iLevel = 1
Function LevelUp()
  int iNewLevel = Game.GetPlayerLevel()
  int iTimesToLevel = iNewLevel - iLevel
  int i = 0
  While (i < iTimesToLevel)
    Game.GetPlayer().ModValue(PPerkPoints, PPToAdd)
    Game.GetPlayer().ModValue(PSkillPoints, SPToAdd)
    i += 1
  EndWhile
  iLevel = iNewLevel
EndFunction

Function AddPPOnLevelUp(int count)
  PPToAdd += count
EndFunction

Function AddPP(int count)
  Game.GetPlayer().ModValue(PPerkPoints, count)
EndFunction

Function AddSPOnLevelUp(int count)
  SPToAdd += count
EndFunction

Function AddSP(int count)
  Game.GetPlayer().ModValue(PSkillPoints, count)
EndFunction

Group FLs
  FormList Property Pskills_list Auto Const Mandatory
EndGroup

ActorValue Property PPerkPoints Auto Const Mandatory
ActorValue Property PSkillPoints Auto Const Mandatory
