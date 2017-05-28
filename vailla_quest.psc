Scriptname vailla_quest extends FOC_DIALOGUE_UI_CONTROLLER

String Property scene_name = "GreetJoeBerg" AutoReadOnly

Function registercustomevents()
  RegisterForRemoteEvent(PMQ101_006_VaultTecRep, "OnPhaseBegin")
EndFunction


Event Scene.OnPhaseBegin(Scene aScene,int auiPhaseIndex)
  If(aScene == PMQ101_006_VaultTecRep)
    If(auiPhaseIndex == 2)
      SendListEntries(FillEntriesVar())
    EndIf
  EndIf
endEvent

Function OnDialogueOptionReturned(string SceneName, int OptionIdx)
  If (SceneName == scene_name)
    If(OptionIdx == 4)
      PMQ101_006_VaultTecRep.Stop()
      VTR.GetActorReference().Kill()
    EndIf
  EndIf
EndFunction

Var Function FillEntriesVar()
  var[] b = new Var[1]
  b[0] = createListEntry(scene_name,"can u kill urself plox?",16)
  return Utility.VarArrayToVar(b)
EndFunction

ReferenceAlias Property VTR Auto Const

Scene Property PMQ101_006_VaultTecRep Auto Const Mandatory
