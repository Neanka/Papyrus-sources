Scriptname dummyscene4 extends Scene

String Property scene_name = "dummyscene4" AutoReadOnly
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
      testdialogue.wadausellscene_explainoption = 0
      testdialogue.wadausellscene_1option = 1
      testdialogue.wadausellscene_2option = 1
      testdialogue.wadausellscene_3option = 1
      testdialogue.wadausellscene_anotheroption = 1
      testdialogue.wadausellscene_sigsoption = 0
      testdialogue.wadausellscene_firststtimesoption = 0
      Stop()
      Utility.Wait(0.1)
      Pwadayasellanswer1.Start()
    ElseIf(OptionIdx == 5)
      testdialogue.wadausellscene_1option = 0
      Stop()
      Utility.Wait(0.1)
      Pwadayasellanswer2.Start()
    ElseIf(OptionIdx == 6)
      testdialogue.wadausellscene_2option = 0
      Stop()
      Utility.Wait(0.1)
      Pwadayasellanswer3.Start()
    ElseIf(OptionIdx == 7)
      testdialogue.wadausellscene_3option = 0
      Stop()
      Utility.Wait(0.1)
      Pwadayasellanswer4.Start()
    ElseIf(OptionIdx == 8)
      testdialogue.cond_sell = 0
      Stop()
      Utility.Wait(0.1)
      Pwadayasellsmthelse.Start()
    ElseIf(OptionIdx == 9)
      testdialogue.cond_sell = 0
      Stop()
      Utility.Wait(0.1)
      Pwadayasellsigs.Start()
    ElseIf(OptionIdx == 10)
      testdialogue.cond_sell = 0
      Stop()
      Utility.Wait(0.1)
      Pwadayaselltried.Start()
    ElseIf(OptionIdx == 11)
      testdialogue.cond_sell = 0
      Stop()
      Utility.Wait(0.1)
      Pwadayasellquit.Start()
    EndIf
  EndIf
EndFunction

Event OnPhaseBegin(int auiPhaseIndex)
  If(auiPhaseIndex == 2)
    DLG.InitNewDialog(self,scene_name,FillEntriesVar(),testdialogue.returnflag4())
  EndIf
endEvent

Var Function FillEntriesVar()
  var[] b = new Var[0]
  b.add(DLG.createListEntry("Yeah, a little.  What strains do you have?",16))
  b.add(DLG.createListEntry("What is Acapulco Gold?",32))
  b.add(DLG.createListEntry("Tell me about Purple Kush.",64))
  b.add(DLG.createListEntry("I'd like to know more about Radioactive Oblivion.",128))
  b.add(DLG.createListEntry("Let's talk about something else.",256))
  b.add(DLG.createListEntry("Do you mean cigarettes?",512))
  b.add(DLG.createListEntry("I tried it once, but didn't inhale.",1024))
  b.add(DLG.createListEntry("I'm not interested.",2048,aiIcon = DLG.ICON_EXIT))
  return Utility.VarArrayToVar(b)
EndFunction

ActorValue Property PCharisma Auto Const Mandatory
ReferenceAlias Property Dummynpc Auto Const


Group Scenes
testdialoguecontroller Property testdialogue Auto Const
EndGroup

Scene Property Pwadayasellquit Auto Const Mandatory

Scene Property Pgreet Auto Const Mandatory

Scene Property Pwadayasellanswer1 Auto Const Mandatory
Scene Property Pwadayasellanswer2 Auto Const Mandatory
Scene Property Pwadayasellanswer3 Auto Const Mandatory
Scene Property Pwadayasellanswer4 Auto Const Mandatory

Scene Property Pwadayasellsmthelse Auto Const Mandatory

Scene Property Pwadayasellsigs Auto Const Mandatory

Scene Property Pwadayaselltried Auto Const Mandatory
