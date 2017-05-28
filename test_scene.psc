Scriptname test_scene extends Scene

String Property scene_name = "GreetJoeBerg" AutoReadOnly

DLGFramework DLG

Event OnBegin()
  DLG = DLGFramework.GetInstance()
EndEvent

Function OnDialogueOptionReturned(string SceneName, int OptionIdx)
  If (SceneName == scene_name)
    If(OptionIdx == 4)
      If(Game.GetPlayer().GetValue(PCharisma)>5)
        Bart.GetActorReference().Kill()
      Else
        Bart.GetActorReference().StartCombat(Game.GetPlayer())
      EndIf
    ElseIf(OptionIdx == 5)
      Stop()
      Utility.Wait(0.3)
      Bart.GetActorReference().ShowBarterMenu()
    ElseIf(OptionIdx == 6)
      Stop()
      PFCMQ101JoeBergEndGreet.Start()
    ElseIf(OptionIdx == 7)
      Stop()
    EndIf
  EndIf
EndFunction

Event OnPhaseBegin(int auiPhaseIndex)
  If(auiPhaseIndex == 1)
    DLG.InitNewDialog(self,scene_name,FillEntriesVar())
    If(Game.GetPlayer().GetValue(Pskillsbarterfortest)<86)
      Utility.Wait(0.3)
      DLG.SetFiterFlag(31)
    EndIf
  EndIf
endEvent

Var Function FillEntriesVar()
  var[] b = new Var[5]
  b[0] = DLG.createListEntry(scene_name,"[Charisma 5] Could you just do me a favor and fuck off??",16,aiBorderColor = 26163)
  b[1] = DLG.createListEntry(scene_name,"[Barter 75/85] Barter",32,aiBorderColor = 16724787)
  b[2] = DLG.createListEntry(scene_name,"So... Can I have my money back?",16)
  b[3] = DLG.createListEntry(scene_name,"I got to go!",16)
  b[4] = DLG.createListEntry(scene_name,"I have not heard anything, do you? (Give him $$val caps)",16,1,24,1,27,16750899)
  return Utility.VarArrayToVar(b)
EndFunction

Scene Property PFCMQ101JoeBergEndGreet Auto Const Mandatory
ActorValue Property Pskillsbarterfortest Auto Const Mandatory
ActorValue Property PCharisma Auto Const Mandatory
ReferenceAlias Property Bart Auto Const
