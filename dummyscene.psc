Scriptname dummyscene extends Scene

String Property scene_name = "dummyscene" AutoReadOnly
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
      testdialogue.cond_barter = 1
      Pwaddausell.Start()
    ElseIf(OptionIdx == 5)
      Stop()
      Utility.Wait(0.3)
      Dummynpc.GetActorReference().ShowBarterMenu()
    ElseIf(OptionIdx == 6)
      Stop()
      Utility.Wait(0.1)
      Pwatustory.Start()
    ElseIf(OptionIdx == 7) ; Do you have any work?
      Stop()
      Utility.Wait(0.1)
      Phaveanywork.Start()
    ElseIf(OptionIdx == 8) ;  I have to go.
      Stop()
      Utility.Wait(0.1)
      Pseeya.Start()
    EndIf
  EndIf
EndFunction

Event OnPhaseBegin(int auiPhaseIndex)
  If(auiPhaseIndex == 1)
    DLG.InitNewDialog(self,scene_name,FillEntriesVar(),testdialogue.returnflag())
  EndIf
endEvent

Var Function FillEntriesVar()
  var[] b = new Var[0]
  b.add(DLG.createListEntry("What do you sell here?",16))
  b.add(DLG.createListEntry("I'd like to buy some things.",32,aiIcon = DLG.ICON_BARTER))
  b.add(DLG.createListEntry("So what's your story?",64))
  b.add(DLG.createListEntry("Do you have any work?",128,aiIcon = DLG.ICON_QUEST))
  b.add(DLG.createListEntry("I have to go.",256,aiIcon = DLG.ICON_EXIT))
  return Utility.VarArrayToVar(b)
EndFunction

ActorValue Property PCharisma Auto Const Mandatory
ReferenceAlias Property Dummynpc Auto Const


Group Scenes
testdialoguecontroller Property testdialogue Auto Const
EndGroup

Scene Property Pwaddausell Auto Const Mandatory

Scene Property Pwatustory Auto Const Mandatory

Scene Property Phaveanywork Auto Const Mandatory

Scene Property Pseeya Auto Const Mandatory
