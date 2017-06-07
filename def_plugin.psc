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
  RegisterForExternalEvent("LevelUp::Ready", "OnLevelUpReady")
  RegisterForMenuOpenCloseEvent("LevelUpMenu")
  FillUnlearnedPerks(Pperk_list)
  ;def.openmenu("levelupmenu")
EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)
  registercustomevents()
EndEvent

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
  if (asMenuName== "LevelUpMenu")
      if (abOpening)
      endif
  endif
endEvent

Event OnKeyDown(int keyCode)
  If(keyCode == 84)
    Debug.Notification("added 50 exp")
    def.addexp(50)
  ;  Debug.MessageBox(PConcentratedFire01.IsEligible(Game.GetPlayer()))
  ;  def.openmenu("levelupmenu")
  Debug.Trace(Game.GetInstalledPlugins())
  EndIf
  If(keyCode == 89)
OnLevelUpReady()
      ;OnLevelUpReady()
    ;  Debug.MessageBox(def.exe(""))
    ;Debug.Notification("trace actionboy perk")
    ;Debug.MessageBox(def.getperkreqs(PPM_FriendOfTheNight1,Game.GetPlayerLevel()))
    Debug.Trace(def.traceperk(PActionBoy01))
    Debug.Trace(def.traceperk(PPM_FriendOfTheNight1))
    Debug.Trace(def.traceperk(PConcentratedFire01))
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
    If !playerref.HasPerk(PerkList.GetAt(i) as Perk)
      Punlearned_perks.AddForm(PerkList.GetAt(i))
    EndIf
  i += 1
  EndWhile
EndFunction

Group FLs
  FormList Property Pperk_list Auto Const Mandatory
  FormList Property Pskills_list Auto Const Mandatory
  FormList Property Punlearned_perks Auto Const Mandatory
EndGroup

Group perks
  Perk Property PActionBoy01 Auto Const Mandatory
  Perk Property PPM_FriendOfTheNight1 Auto Const Mandatory
  Perk Property PConcentratedFire01 Auto Const Mandatory
EndGroup

ActorValue Property PPerkPoints Auto Const Mandatory
ActorValue Property PSkillPoints Auto Const Mandatory
