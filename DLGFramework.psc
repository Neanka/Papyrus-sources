Scriptname DLGFramework extends Quest

actor playerref

int Property iVersion = 10 AutoReadOnly

Struct dialogueentries
    string sScene
    string qtext
    int iFilterFlag
    int qType
    int qVal
    int qMinVal
    int qMaxVal
    int qTextColor
    int qBorderColor
EndStruct

ScriptObject currentscenescript

bool menuopened = false
bool varsended = true
bool flagsended = true
var queuedvar
int queuedflag
string currentscenename = "None"
InputEnableLayer myLayer

bool Function checkVersion(int iaReqVersion)
  If (GetVersion() < iaReqVersion)
    return false
  Else
    return true
  EndIf
EndFunction

int Function GetVersion()
  return iVersion
EndFunction

Event OnQuestInit()
  playerref = Game.GetPlayer()
  RegisterForRemoteEvent(playerref, "OnPlayerLoadGame")
  registercustomevents()
EndEvent

Function registercustomevents()
  myLayer = InputEnableLayer.Create()
  RegisterForExternalEvent("Dialogue::OptionReturned", "OnDialogueOptionReturned")
  RegisterForMenuOpenCloseEvent("DialogueMenu")
EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)
  registercustomevents()
EndEvent

DLGFramework Function GetInstance() global
    If (Game.IsPluginInstalled("DLGFramework.esm"))
        return Game.GetFormFromFile(0xF99, "DLGFramework.esm") as DLGFramework
    Else
        return None
    EndIf
EndFunction

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
  if (asMenuName== "DialogueMenu")
      if (abOpening)
        var d = playerref.GetDialogueTarget().GetBaseObject().GetName()
        UI.Set("DialogueMenu", "root.name_tf.text", d)
        myLayer.EnableCamSwitch(false)
        myLayer.EnableMovement(false)
        menuopened = true
        If(!varsended)
          requestsendvar(queuedvar)
        EndIf
        If(!flagsended)
          requestsendflag(queuedflag)
        EndIf
      else
        myLayer.EnableCamSwitch()
        myLayer.EnableMovement()
        menuopened = false
      endif
  endif
endEvent

Function SetFiterFlag(int iFilterFlag) ; 1 2 4 8
  If(menuopened)
    requestsendflag(iFilterFlag)
  Else
    queuedflag = iFilterFlag
    flagsended = false
  EndIf
EndFunction

Function ShowAlloptions()
  If(menuopened)
    requestsendflag(2147483647)
  Else
    queuedflag = 2147483647
    flagsended = false
  EndIf
EndFunction

Function requestsendflag(int flag)
  Var[] a = new Var[1]
  a[0] = flag
  UI.Invoke("DialogueMenu", "root.setfilterflag", a)
  flagsended = true
EndFunction


; colors: 16777215 white, 26163 green , 16724787 red, 16750899 orange

dialogueentries Function createListEntry(string asScene, string asText, int aiFF = 16, int aiType = 0, int aiVal = 0, int aiMinVal = 0, int aiMaxVal = 0, int aiTextColor = 16777215, int aiBorderColor = 16777215)
  dialogueentries so = new dialogueentries
  so.sScene = asScene
  so.qtext = asText
  so.iFilterFlag = aiFF
  so.qType = aiType
  so.qVal = aiVal
  so.qMinVal = aiMinVal
  so.qMaxVal = aiMaxVal
  so.qTextColor = aiTextColor
  so.qBorderColor = aiBorderColor
  return so
EndFunction

Function requestsendvar(Var avar)
  UI.Set("DialogueMenu", "root.scenename", currentscenename)
  UI.Set("DialogueMenu", "root.customentries", avar)
  UI.Invoke("DialogueMenu", "root.customentriesrecieved")
  varsended = true
EndFunction

Function InitNewDialog(ScriptObject ascript,String ascenename, Var avar, int aFFlag = 2147483647)
  currentscenescript = ascript
  currentscenename = ascenename
  If(menuopened)
    requestsendvar(avar)
    requestsendflag(aFFlag)
  Else
    queuedvar = avar
    varsended = false
    queuedflag = aFFlag
    flagsended = false
  EndIf
EndFunction

Function OnDialogueOptionReturned(string SceneName, int OptionIdx)
    Var[] a = new Var[2]
    a[0] = SceneName
    a[1] = OptionIdx
    currentscenescript.CallFunctionNoWait("OnDialogueOptionReturned", a)
EndFunction
