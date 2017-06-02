Scriptname dummyscene3 extends Scene

String Property scene_name = "dummyscene3" AutoReadOnly
int Property iVersion = 1 AutoReadOnly
int Property iFWNeedeVersion = 10 AutoReadOnly

DLGFramework DLG

Event OnBegin()
  DLG = DLGFramework.GetInstance()
  DLG.checkVersion(iFWNeedeVersion)
EndEvent

Function OnDialogueOptionReturned(string SceneName, int OptionIdx, int val)
  If (SceneName == scene_name)
    If(OptionIdx == 4)
      If(Game.GetPlayer().GetValue(PCharisma)>2)
        testdialogue.questacceptscene_1stoption = 0
        testdialogue.questacceptscene_2ndoption = 1
        testdialogue.quest_reward = 100
        Stop()
        Utility.Wait(0.1)
        Pfirstcharchecksucc.Start()
      Else
        testdialogue.questacceptscene_1stoption = 0
        Stop()
        Utility.Wait(0.1)
        Pfirstcharcheckfail.Start()
      EndIf
    ElseIf(OptionIdx == 5)
      If(Game.GetPlayer().GetValue(PCharisma)>4)
        testdialogue.questacceptscene_2ndoption = 0
        testdialogue.questacceptscene_3rdoption = 1
        Stop()
        Utility.Wait(0.1)
        Psecondcharchecksucc.Start()
      Else
        testdialogue.questacceptscene_2ndoption = 0
        testdialogue.quest_reward = 50
        Stop()
        Utility.Wait(0.1)
        Pfirstcharcheckfail.Start()
      EndIf
    ElseIf(OptionIdx == 6)
      If(50+20*Game.GetPlayer().GetValue(PCharisma)>val)
        testdialogue.questacceptscene_3rdoption = 0
        testdialogue.quest_reward = val
        Stop()
        Utility.Wait(0.1)
        Pthirdchecksuccess.Start()
      Else
        testdialogue.questacceptscene_3rdoption = 0
        testdialogue.quest_reward = 50
        Stop()
        Utility.Wait(0.1)
        Pfirstcharcheckfail.Start()
      EndIf
    ElseIf(OptionIdx == 7)
      Stop()
      Utility.Wait(0.1)
      Pgreet.Start()
    ElseIf(OptionIdx == 8); Consider it done.
      testdialogue.cond_quest = 0
      Stop()
      Utility.Wait(0.1)
      Pdummyquest.Start()
      Pdummyquest.SetObjectiveDisplayed(10)
      Pquestaccepted.Start()
    EndIf
  EndIf
EndFunction

Event OnPhaseBegin(int auiPhaseIndex)
  If(auiPhaseIndex == 3)
    DLG.InitNewDialog(self,scene_name,FillEntriesVar(),testdialogue.returnflag3())
    DLG.SetQuestReward(testdialogue.quest_reward)
  EndIf
endEvent

Var Function FillEntriesVar()
  var[] b = new Var[0]
  If(Game.GetPlayer().GetValue(PCharisma)>2)
    b.add(DLG.createListEntry("[Charisma 3] That hardly seems enough.  There could be anything out there.  You want me to get mangled by a deathclaw for 50 caps?",16,aiBorderColor = DLG.ct_green))
  Else
    b.add(DLG.createListEntry("[Charisma"+Game.GetPlayer().GetValue(PCharisma) as int+"/3] That hardly seems enough.  There could be anything out there.  You want me to get mangled by a deathclaw for 50 caps?",16,aiBorderColor = DLG.ct_red))
  EndIf
  If(Game.GetPlayer().GetValue(PCharisma)>4)
    b.add(DLG.createListEntry("[Charisma 5] That still seems a bit low.  For all I know you're hauling feral bait and they could wind up picking chunks of meat out of their teeth that used to be me.",32,aiBorderColor = DLG.ct_green))
  Else
    b.add(DLG.createListEntry("[Charisma"+Game.GetPlayer().GetValue(PCharisma) as int+"/5] That still seems a bit low.  For all I know you're hauling feral bait and they could wind up picking chunks of meat out of their teeth that used to be me.",32,aiBorderColor = DLG.ct_red))
  EndIf
  b.add(DLG.createListEntry("I think $$val caps will enough.",64,1,100,100,300))
  b.add(DLG.createListEntry("Let me think about it.",128))
  b.add(DLG.createListEntry("Consider it done.",256))
  return Utility.VarArrayToVar(b)
EndFunction

Group quest
  testdialoguecontroller Property testdialogue Auto Const
EndGroup

ActorValue Property PCharisma Auto Const Mandatory

Scene Property Pgreet Auto Const Mandatory

Scene Property Pfirstcharcheckfail Auto Const Mandatory

Scene Property Pfirstcharchecksucc Auto Const Mandatory

Scene Property Psecondcharchecksucc Auto Const Mandatory

Scene Property Pthirdchecksuccess Auto Const Mandatory

Quest Property Pdummyquest Auto Const Mandatory

Scene Property Pquestaccepted Auto Const Mandatory

Scene Property Pquestdelayed Auto Const Mandatory
