Scriptname dummyscene2 extends Scene

String Property scene_name = "dummyscene2" AutoReadOnly
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
      Stop()
      Utility.Wait(0.1)
      testdialogue.cond_1stoption = 0
      Pstoryanswer1.Start()
    ElseIf(OptionIdx == 5)
      Stop()
      Utility.Wait(0.1)
      testdialogue.cond_2ndoption = 0
      Pstoryanswer2.Start()
    ElseIf(OptionIdx == 6)
      Stop()
      Utility.Wait(0.1)
      testdialogue.cond_3rdoption = 0
      Pstoryanswer3.Start()
    EndIf
  EndIf
EndFunction

Event OnPhaseBegin(int auiPhaseIndex)
  If(auiPhaseIndex == 3)
    If(testdialogue.returnflag2() == 0)
      Stop()
      testdialogue.cond_story = 0
      testdialogue.cond_quest = 1
      Utility.Wait(0.1)
      Pgreet.Start()
    Else
      DLG.InitNewDialog(self,scene_name,FillEntriesVar(),testdialogue.returnflag2())
    EndIf
  EndIf
endEvent

Var Function FillEntriesVar()
  var[] b = new Var[0]
  b.add(DLG.createListEntry("Whoa!  Calm down.  I was just curious.",16))
  b.add(DLG.createListEntry("Hold on.  You were raised by a ghoul?",32))
  b.add(DLG.createListEntry("You look healthy enough.  Why do you think you have a chem problem?",64))
  return Utility.VarArrayToVar(b)
EndFunction

ReferenceAlias Property Dummynpc Auto Const

Group Scenes
testdialoguecontroller Property testdialogue Auto Const
EndGroup

Scene Property Pwaddausell Auto Const Mandatory

Scene Property Pstoryanswer1 Auto Const Mandatory

Scene Property Pstoryanswer2 Auto Const Mandatory

Scene Property Pstoryanswer3 Auto Const Mandatory

Scene Property Pgreet Auto Const Mandatory
