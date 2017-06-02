Scriptname testdialoguecontroller extends Quest

int Property filterflag = 0 Auto
int Property cond_barter = 0 Auto
int Property cond_story = 1 Auto
int Property cond_sell = 1 Auto
int Property cond_quest = 0 Auto

Group secondscene
  int Property cond_1stoption = 1 Auto
  int Property cond_2ndoption = 1 Auto
  int Property cond_3rdoption = 1 Auto
EndGroup

Group questacceptscene
  int Property questacceptscene_1stoption = 1 Auto
  int Property questacceptscene_2ndoption = 0 Auto
  int Property questacceptscene_3rdoption = 0 Auto
EndGroup

Group wadausellscene
  int Property wadausellscene_explainoption = 1 Auto
  int Property wadausellscene_1option = 0 Auto
  int Property wadausellscene_2option = 0 Auto
  int Property wadausellscene_3option = 0 Auto
  int Property wadausellscene_anotheroption = 0 Auto
  int Property wadausellscene_sigsoption = 1 Auto
  int Property wadausellscene_firststtimesoption = 1 Auto
  int Property wadausellscene_exitoption = 1 Auto
EndGroup

int Property quest_reward = 50 Auto

int Function returnflag()
  filterflag = 16*cond_sell+32*cond_barter+64*cond_story+128*cond_quest+256
  return filterflag
EndFunction

int Function returnflag2()
  filterflag = 16*cond_1stoption+32*cond_2ndoption+64*cond_3rdoption
  return filterflag
EndFunction

int Function returnflag3()
  filterflag = 16*questacceptscene_1stoption+32*questacceptscene_2ndoption+64*questacceptscene_3rdoption+128+256
  return filterflag
EndFunction

int Function returnflag4()
  filterflag = 16*wadausellscene_explainoption+32*wadausellscene_1option+64*wadausellscene_2option+128*wadausellscene_3option+256*wadausellscene_anotheroption+512*wadausellscene_sigsoption+1024*wadausellscene_firststtimesoption+2048
  return filterflag
EndFunction
