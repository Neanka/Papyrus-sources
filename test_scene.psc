Scriptname test_scene extends Scene

String Property scene_name = "GreetJoeBerg" AutoReadOnly
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
    ElseIf(OptionIdx == 8)
      DLG.Removeflag(64)
    EndIf
  EndIf
EndFunction

Event OnPhaseBegin(int auiPhaseIndex)
  If(auiPhaseIndex == 1)
    DLG.InitNewDialog(self,scene_name,FillEntriesVar())
  EndIf
endEvent

Var Function FillEntriesVar()
  var[] b = new Var[5]
  b[0] = DLG.createListEntry("[Charisma 5] Could you just do me a favor and fuck off??",16,aiBorderColor = DLG.ct_green)
  b[1] = DLG.createListEntry("[Barter 75/85] Barter",32,aiBorderColor = DLG.ct_red)
  b[2] = DLG.createListEntry("So... Can I have my money back?",16)
  b[3] = DLG.createListEntry("I got to go!",16)
  b[4] = DLG.createListEntry("I have not heard anything, do you? (Give him $$val caps)",64,1,24,1,27,DLG.ct_orange)
  return Utility.VarArrayToVar(b)
EndFunction

Scene Property PFCMQ101JoeBergEndGreet Auto Const Mandatory
ActorValue Property Pskillsbarterfortest Auto Const Mandatory
ActorValue Property PCharisma Auto Const Mandatory
ReferenceAlias Property Bart Auto Const
