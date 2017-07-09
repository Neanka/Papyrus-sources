Scriptname FOC_SPController extends PRKF_quest

actor playerref
int skillscount

Function setvariables()
  sname = "NV Skills"
  pluginname = "foc_skillspoints_test.esp"
  iVersion = 1
  iFWNeededVersion = 1
  iPPOnLevelUp = 0
  iSPOnLevelUp = 0
EndFunction

Event OnInit()
  playerref = Game.GetPlayer()
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  registerevents()
EndEvent

Function DoMagic()
  AddSkillsToStart(PSkillsList)
EndFunction

Event Actor.OnPlayerLoadGame(Actor aSender)
  registerevents()
EndEvent

Function registerevents()
  RegisterForMenuOpenCloseEvent("SPECIALMenu")
  RegisterForMenuOpenCloseEvent("LevelUpMenu")
  RegisterForExternalEvent("myeventname", "OnMyCallback")
  RegisterForExternalEvent("healH", "OnhealH")
  RegisterForExternalEvent("requestskills", "Onrequestskills")

;  RegisterForExternalEvent("LevelUpInit", "OnLevelUpInit")
;  RegisterForExternalEvent("LevelUp::RequestSkills", "OnLevelUpRequestSkills")
  ;RegisterForExternalEvent("LevelUp::ReturnSkills", "OnLevelUpReturnSkills")
EndFunction

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
  if (asMenuName== "SPECIALMenu")
      if (!abOpening)
        playerref.ModValue(PSkillsBarter, CalculateStartingSkill(pCharisma))
        playerref.ModValue(PSkillsCrafting, CalculateStartingSkill(pIntelligence))
        playerref.ModValue(PSkillsEnergyWeapons, CalculateStartingSkill(pPerception))
        playerref.ModValue(PSkillsExplosives, CalculateStartingSkill(pPerception))
        playerref.ModValue(PSkillsGuns, CalculateStartingSkill(pAgility))
        playerref.ModValue(PSkillsLockPick, CalculateStartingSkill(pPerception))
        playerref.ModValue(PSkillsMedicine, CalculateStartingSkill(pIntelligence))
        playerref.ModValue(PSkillsMeleeWeapons, CalculateStartingSkill(pStrength))
        playerref.ModValue(PSkillsScience, CalculateStartingSkill(pIntelligence))
        playerref.ModValue(PSkillsSneak, CalculateStartingSkill(pAgility))
        playerref.ModValue(PSkillsSpeech, CalculateStartingSkill(pCharisma))
        playerref.ModValue(PSkillsSurvival, CalculateStartingSkill(pEndurance))
        playerref.ModValue(PSkillsUnarmed, CalculateStartingSkill(pEndurance))
        ;Debugskills()
        UnRegisterForMenuOpenCloseEvent("SPECIALMenu")
      endif
  endif
  if (asMenuName== "LevelUpMenu")
      if (abOpening)
      ;  OnLevelUpRequestSkills()
      endif
  endif
endEvent

Function OnMyCallback()
  Debug.Notification("f4seinitialized")
;  Debug.Messagebox(PSkillsBarter.GetDescription())
  UI.Invoke("PipboyMenu", "root.papyruscall2", new Var[0])

EndFunction

;------------------LevelupMenu-------------------------------
Function OnLevelUpInit()
  Debug.Notification("LevelupMenu: f4seinitialized")
EndFunction

Function OnLevelUpRequestSkills()
  Debug.Notification("LevelupMenu: skills requested")
   Var[] a = new Var[2]
   a[0] = playerref.GetValue(PSkillPoints) as int
   a[1] = FillSkillsVar();Utility.VarArrayToVar(b)
   UI.Invoke("LevelUpMenu", "root.Menu_mc.onRequestSkills", a)
EndFunction

Function OnLevelUpReturnSkills(Var[] a3)
  Debug.Notification("LevelupMenu: skills RETURNED")
  playerref.SetValue(PSkillPoints, 0)
  playerref.ModValue(PSkillsBarter, a3[0] as float)
  playerref.ModValue(PSkillsCrafting, a3[1] as float)
  playerref.ModValue(PSkillsEnergyWeapons, a3[2] as float)
  playerref.ModValue(PSkillsExplosives, a3[3] as float)
  playerref.ModValue(PSkillsGuns, a3[4] as float)
  playerref.ModValue(PSkillsLockPick, a3[5] as float)
  playerref.ModValue(PSkillsMedicine, a3[6] as float)
  playerref.ModValue(PSkillsMeleeWeapons, a3[7] as float)
  playerref.ModValue(PSkillsScience, a3[8] as float)
  playerref.ModValue(PSkillsSneak, a3[9] as float)
  playerref.ModValue(PSkillsSpeech, a3[10] as float)
  playerref.ModValue(PSkillsSurvival, a3[11] as float)
  playerref.ModValue(PSkillsUnarmed, a3[12] as float)
  Onrequestskills()
EndFunction
;----------------EOLevelupMenu-------------------------------



Function OnhealH()
  Debug.Messagebox("hello from papyrus\n let's heal ur Head with doctor's bag")
  UI.Invoke("PipboyMenu", "root.headhealed", new Var[0])
EndFunction

Struct skillsforsf
    string stext
    string sdescription
    int ivalue
    int iclipIndex
    int imodifier
EndStruct

int Function CalculateStartingSkill(ActorValue AVIF)
  return 2+2*(playerref.GetValue(AVIF) as int)+Math.Ceiling(playerref.GetValue(PLuck)/2)
EndFunction

Function Onrequestskills()
  Debug.Notification("PipboyMenu: Skills Requested")

  UI.Set("PipboyMenu", "root.testvar", FillSkillsVar())
  UI.Invoke("PipboyMenu", "root.skillsrecieved")
EndFunction

Var Function FillSkillsVar()
  var[] b = new Var[13]
  skillscount = 0
  b[0] = getSkillsForSF(PSkillsBarter)
  b[1] = getSkillsForSF(PSkillsCrafting)
  b[2] = getSkillsForSF(PSkillsEnergyWeapons)
  b[3] = getSkillsForSF(PSkillsExplosives)
  b[4] = getSkillsForSF(PSkillsGuns)
  b[5] = getSkillsForSF(PSkillsLockPick)
  b[6] = getSkillsForSF(PSkillsMedicine)
  b[7] = getSkillsForSF(PSkillsMeleeWeapons)
  b[8] = getSkillsForSF(PSkillsScience)
  b[9] = getSkillsForSF(PSkillsSneak)
  b[10] = getSkillsForSF(PSkillsSpeech)
  b[11] = getSkillsForSF(PSkillsSurvival)
  b[12] = getSkillsForSF(PSkillsUnarmed)
  return Utility.VarArrayToVar(b)
EndFunction

skillsforsf Function getSkillsForSF(ActorValue AVIF)
  skillsforsf so = new skillsforsf
  so.ivalue = playerref.GetValue(AVIF) as int
  so.stext = AVIF.GetName()
  so.sdescription = AVIF.GetDescription()
  so.iclipIndex = skillscount
  so.imodifier = 0
  skillscount+=1
  return so
EndFunction

Function debugskills()
  Debug.MessageBox("crafting "+playerref.GetValue(PSkillsCrafting) as int+"\nbarter "+playerref.GetValue(PSkillsBarter) as int+"\nE Weapons "+playerref.GetValue(PSkillsEnergyWeapons) as int+"\nExplosives "+playerref.GetValue(PSkillsExplosives) as int+"\nGuns "+playerref.GetValue(PSkillsGuns) as int+"\nLockPick "+playerref.GetValue(PSkillsLockPick) as int+"\nMedicine "+playerref.GetValue(PSkillsMedicine) as int+"\nMelee weapons "+playerref.GetValue(PSkillsMeleeWeapons) as int+"\nScience "+playerref.GetValue(PSkillsScience) as int+"\nSneak "+playerref.GetValue(PSkillsSneak) as int+"\nSpeech "+playerref.GetValue(PSkillsSpeech) as int+"\nsurvival "+playerref.GetValue(PSkillsSurvival) as int+"\nunarmed "+playerref.GetValue(PSkillsUnarmed) as int)

EndFunction

Group AVIFs
  ActorValue Property pStrength Auto Const Mandatory
  ActorValue Property pPerception Auto Const Mandatory
  ActorValue Property pEndurance Auto Const Mandatory
  ActorValue Property pCharisma Auto Const Mandatory
  ActorValue Property pIntelligence Auto Const Mandatory
  ActorValue Property pAgility Auto Const Mandatory
  ActorValue Property PLuck Auto Const Mandatory
  ActorValue Property PSkillPoints Auto Const Mandatory
  ActorValue Property PSkillsCrafting Auto Const Mandatory
  ActorValue Property PSkillsBarter Auto Const Mandatory
  ActorValue Property PSkillsEnergyWeapons Auto Const Mandatory
  ActorValue Property PSkillsExplosives Auto Const Mandatory
  ActorValue Property PSkillsGuns Auto Const Mandatory
  ActorValue Property PSkillsLockPick Auto Const Mandatory
  ActorValue Property PSkillsMedicine Auto Const Mandatory
  ActorValue Property PSkillsMeleeWeapons Auto Const Mandatory
  ActorValue Property PSkillsScience Auto Const Mandatory
  ActorValue Property PSkillsSneak Auto Const Mandatory
  ActorValue Property PSkillsSpeech Auto Const Mandatory
  ActorValue Property PSkillsSurvival Auto Const Mandatory
  ActorValue Property PSkillsUnarmed Auto Const Mandatory
EndGroup

ActorValue Property PPerkPoints Auto Const Mandatory

FormList Property PSkillsList Auto Const Mandatory
