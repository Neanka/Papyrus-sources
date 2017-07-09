Scriptname my_awesome_perk extends PRKF_quest

Function setvariables()
  sname = "My awesome perk"
  pluginname = "my_awesome_perk.esp"
  iVersion = 1
  iFWNeededVersion = 1
  iPPOnLevelUp = 10 ;yeah i wanna 10 perk points on level up
;  iSPOnLevelUp = 0
EndFunction

Function DoMagic()
  AddPerks(Pperkstoadd)
;  AddSkills(Pskillstoadd)
  AddPPOnLvlUp()
;  AddSPOnLvlUp()
EndFunction

FormList Property Pperkstoadd Auto Const Mandatory
;FormList Property Pskillstoadd Auto Const Mandatory
