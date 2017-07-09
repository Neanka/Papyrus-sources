Scriptname PRKF_VanillaPerksController extends PRKF_quest

Function setvariables()
  sname = "Vanilla Perks"
  pluginname = "PRKF_VanillaPerks.esp"
  iVersion = 1
  iFWNeededVersion = 1
  iPPOnLevelUp = 1
  iSPOnLevelUp = 0
EndFunction

Function DoMagic()
  AddPerksToStart(Pvanilla_perks)
  AddPPOnLvlUp()
EndFunction

FormList Property Pvanilla_perks Auto Const Mandatory
