Scriptname PRKF_PM_Perks_controller extends PRKF_quest

Function setvariables()
  sname = "PM Perks"
  pluginname = "PRKF_PMPerks.esp"
  iVersion = 1
  iFWNeededVersion = 1
  iPPOnLevelUp = 1
  iSPOnLevelUp = 0
EndFunction

Function DoMagic()
  AddPerks(PPM_perks)
  AddPPOnLvlUp()
EndFunction

FormList Property PPM_perks Auto Const Mandatory

Perk Property PPM_Intense_training01 Auto Const Mandatory

Perk Property PPM_Almost_Perfect01 Auto Const Mandatory

Perk Property PPM_No_Weaknesses01 Auto Const Mandatory
