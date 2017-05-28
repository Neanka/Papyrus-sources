Scriptname FOC_Lvlup_controller extends Quest

Event OnInit()
  int gainedlevel = game.GetPlayer().GetLevel()

  if gainedlevel>1
    int gainedpoints =  10+Math.Ceiling(game.GetPlayer().GetValue(pIntelligence)/2)
    float oldpoints = game.GetPlayer().GetValue(PSkillPoints)
    game.GetPlayer().SetValue(PSkillPoints, oldpoints+gainedpoints)
    game.GetPlayer().ModValue(PPerkPoints, 1)
    int totalpoints = game.GetPlayer().GetValue(PSkillPoints) as int
    Debug.Notification("just reached lvl "+gainedlevel +"\ngain "+gainedpoints +" skillpoints\ncurrent skillpoints : "+totalpoints+"\ncurrent perkpoints : "+game.GetPlayer().GetValue(PPerkPoints) as int )
    Stop()
  endif
EndEvent
ActorValue Property pIntelligence Auto Const Mandatory

ActorValue Property PSkillPoints Auto Const Mandatory

ActorValue Property PPerkPoints Auto Const Mandatory
