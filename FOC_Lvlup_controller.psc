Scriptname FOC_Lvlup_controller extends Quest

PRKFramework PRK
String Property sname = "NV Skills levelup controller" AutoReadOnly
int Property iVersion = 1 AutoReadOnly
int Property iFWNeedeVersion = 1 AutoReadOnly

Event OnInit()
  PRK = PRKFramework.GetInstance()
  PRK.checkVersion(iFWNeedeVersion,sname)
  if Game.GetPlayerLevel() > 1
    int gainedpoints =  10+Math.Ceiling(game.GetPlayer().GetValue(pIntelligence)/2)
    PRK.AddSP(gainedpoints)
  endif
  Stop()
EndEvent
ActorValue Property pIntelligence Auto Const Mandatory

ActorValue Property PSkillPoints Auto Const Mandatory

ActorValue Property PPerkPoints Auto Const Mandatory
