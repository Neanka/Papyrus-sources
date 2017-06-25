Scriptname PRKF_base_lvlup_controller extends Quest

PRKFramework PRK

Event OnInit()
  PRK = PRKFramework.GetInstance()
  PRK.LevelUp()
  Stop()
EndEvent

ActorValue Property PPerkPoints Auto Const Mandatory
ActorValue Property PSkillPoints Auto Const Mandatory
