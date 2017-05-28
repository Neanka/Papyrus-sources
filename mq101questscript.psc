Scriptname MQ101QuestScript extends Quest Conditional

; Stores the enable layer being used to disable player controls during CharGen
InputEnableLayer Property MQ101EnableLayer Auto Hidden

ReferenceAlias Property SpousePod Auto

ObjectReference Property PrewarVaultElevatorRef Auto

String SwitchesToMale = "MaleAtMirror"
String SwitchesToFemale = "FemaleAtMirror"

int MirrorIdleTimer = 30
int MirrorIdleTalkTimerID = 10

;0 = male, 1 = female
int var_PlayerGender = 0
int RunMirrorTimer = 0

;track when the spouse goes to the other sink furniture
int Property var_MirrorSequenceDone Auto Conditional

Keyword Property CharGenSpouseMirrorWaitTopic Auto
ReferenceAlias Property ActiveSpouse Auto
Keyword Property AnimFaceArchetypeNeutral Auto
Keyword Property AnimFaceArchetypeAmused Auto
Keyword Property AnimFaceArchetypeImpressed Auto
Keyword Property CharGenGenderSwitchTopic Auto

;turn off comments until timer hits
int var_CommentsOff ; 1 = spouse commentted last, 2 = player commentted last
int CommentTimerID = 10
GlobalVariable Property FaceCommentTimer Auto

ObjectReference Property CgNukeShockWaveRef Auto

ReferenceAlias Property BabyActivator Auto
ReferenceAlias Property SpouseMale Auto
ReferenceAlias Property SpouseFemale Auto

ObjectReference Property MQ101SpouseMaleMovetoMarker Auto


;this is to handle when the Player has been fully reset to be Female if the player changes gender
;we need to make sure the reset is done before we can allow you to switch to third, otherwise you'll still be male for a few seconds while the reset happens
;we unload the animation graph when we do the chargenskeleton reset, so we actually want to listen for when the animation event unregisters
Event OnAnimationEventUnregistered(ObjectReference akSource, string asEventName)
	If asEventName == "FirstPersonInitialized"
		;delay enabling third person until after the animation state has fully started
		RegisterForAnimationEvent(Game.GetPlayer(), "initiateStart")		
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)

	Actor PlayerREF = Game.GetPlayer()
	Actor SpouseREF = ActiveSpouse.GetActorRef()

	;enable third person when the animation state has fully started
	If (aksource == PlayerREF) && (asEventName == "initiateStart")
		UnRegisterForAnimationEvent(PlayerREF, "initiateStart")	
		debug.trace(self + "initiateStart")
		debug.trace(Self + "Enabling CamSwitch")
		MQ101EnableLayer.EnableCamSwitch()
	EndIf

	;tracker for menu exit
	;We only call this if the Player is female and we had to reset the Player actor to be female
	If (aksource == PlayerREF) && (asEventName == "CharGenSkeletonReset")
		UnregisterForAnimationEvent(PlayerREF, "ChargenSkeletonReset")
		;track when we can enable third person
		RegisterForAnimationEvent(PlayerREF, "FirstPersonInitialized")

		;pull the chargen skeleton off the player before we disable the FemaleSpouse
		PlayerREF.SetHasCharGenSkeleton(False)
		SpouseFemale.GetActorRef().SetHasCharGenSkeleton(False)
		;if the player exits the menu as female, disable the female spouse and put the male spouse in the bathroom
		SpouseFemale.GetActorRef().DisableNoWait()
		SpouseMale.GetActorRef().moveto(MQ101SpouseMaleMovetoMarker)
	EndIf

	;tracker for mirror gender switches
	If (akSource == PlayerREF) && (asEventName == SwitchesToFemale)
		var_PlayerGender = 1
		SpouseREF.SayCustom(CharGenGenderSwitchTopic)
	EndIf

	If (akSource == PlayerREF) && (asEventName == SwitchesToMale)
		var_PlayerGender = 0
		PlayerREF.SayCustom(CharGenGenderSwitchTopic)
	EndIf

	If (akSource == SpousePod.GetRef()) && (asEventName == "TransitionComplete")
		UnRegisterForAnimationEvent(SpousePod.GetRef(), "TransitionComplete")
		SetStage(785)
	EndIF

	If (akSource == PrewarVaultElevatorRef) && (asEventName == "FadetoBlack")
		UnRegisterForAnimationEvent(PrewarVaultElevatorRef, "FadetoBlack")
		SetStage(530)
	EndIf

	;nuke
	if (akSource == CgNukeShockWaveRef) && (asEventName == "WaveAboutToHit")
		SetStage(505)
	EndIf

	if (akSource == CgNukeShockWaveRef) && (asEventName == "WavePeopleReact")
		SetStage(515)
	EndIf
EndEvent

;we need to know whenever the player switches gender at the mirror, since we don't actually set that data on the player form until you leave the menu
Function TrackMirrorGenderSwitch()
	RegisterForAnimationEvent(Game.GetPlayer(), SwitchesToFemale)
	RegisterForAnimationEvent(Game.GetPlayer(), SwitchesToMale)
	RegisterForLooksMenuEvent()
	RunMirrorTimer = 1
	;StartTimer(MirrorIdleTimer, MirrorIdleTalkTimerID)
EndFunction

Function StopTrackingMirrorGenderSwitch()
	UnRegisterForAnimationEvent(Game.GetPlayer(), SwitchesToFemale)
	UnRegisterForAnimationEvent(Game.GetPlayer(), SwitchesToMale)
	RunMirrorTimer = 0
	;CancelTimer(MirrorIdleTalkTimerID)
	UnregisterForLooksMenuEvent()
EndFunction

Keyword Property CharGenSpouseCommentBeard Auto
Keyword Property CharGenSpouseCommentEye Auto
Keyword Property CharGenSpouseCommentHair Auto
Keyword Property CharGenSpouseCommentMouth Auto
Keyword Property CharGenSpouseCommentNose Auto
Keyword Property CharGenPlayerMirrorWaitTopic Auto

;have the spouse say something, then time it so the player says something, then the spouse, and so on
Event OnLooksMenuEvent(int aiFlavor)
	;always play the first comment, then start timer
	If var_CommentsOff == 0
		PlayFaceGenComment(aiFlavor)
		var_CommentsOff = 1
		StartTimer(FaceCommentTimer.GetValueInt(), CommentTimerID)
	ElseIf var_CommentsOff == 2
		PlayerFaceGenCommentPlayer(aiFlavor)
		var_CommentsOff = 3
		StartTimer(FaceCommentTimer.GetValueInt(), CommentTimerID)
	EndIf
EndEvent

GlobalVariable Property FaceCommentRegion Auto

Function PlayerFaceGenCommentPlayer(int aiFlavor)
	Actor CurrentPlayerREF

	If var_PlayerGender == 0
		CurrentPlayerREF = Game.GetPlayer()
	Else
		CurrentPlayerREF = ActiveSpouse.GetActorRef()
	EndIf	

	If CurrentPlayerREF.IsTalking() == False
		;general banter
		if aiflavor == 0
			FaceCommentRegion.SetValue(0.0)
			CurrentPlayerREF.SayCustom(CharGenPlayerMirrorWaitTopic)
		;eye banter
		ElseIf aiFlavor == 1
			FaceCommentRegion.SetValue(1.0)
			CurrentPlayerREF.SayCustom(CharGenPlayerMirrorWaitTopic)
		;nose banter
		ElseIf aiFlavor == 2
			FaceCommentRegion.SetValue(2.0)
			CurrentPlayerREF.SayCustom(CharGenPlayerMirrorWaitTopic)
		;mouth banter
		ElseIf aiFlavor == 3
			FaceCommentRegion.SetValue(3.0)
			CurrentPlayerREF.SayCustom(CharGenPlayerMirrorWaitTopic)
		;hair banter
		ElseIf aiFlavor == 4
			FaceCommentRegion.SetValue(4.0)
			CurrentPlayerREF.SayCustom(CharGenPlayerMirrorWaitTopic)
		;beard banter
		ElseIf aiFlavor == 5
			FaceCommentRegion.SetValue(5.0)
			CurrentPlayerREF.SayCustom(CharGenPlayerMirrorWaitTopic)
		EndIf
	EndIf
EndFunction

Function PlayFaceGenComment(int aiFlavor)
	Actor SpouseCommenterREF

	If var_PlayerGender == 0
		SpouseCommenterREF = ActiveSpouse.GetActorRef()
	Else
		SpouseCommenterREF = Game.GetPlayer()
	EndIf

	If SpouseCommenterREF.IsTalking() == False
		;general banter
		if aiflavor == 0
			FaceCommentRegion.SetValue(0.0)
			SpouseCommenterREF.SayCustom(CharGenSpouseMirrorWaitTopic)
		;eye banter
		ElseIf aiFlavor == 1
			FaceCommentRegion.SetValue(1.0)
			SpouseCommenterREF.SayCustom(CharGenSpouseCommentEye)
		;nose banter
		ElseIf aiFlavor == 2
			FaceCommentRegion.SetValue(2.0)
			SpouseCommenterREF.SayCustom(CharGenSpouseMirrorWaitTopic)
		;mouth banter
		ElseIf aiFlavor == 3
			FaceCommentRegion.SetValue(3.0)
			SpouseCommenterREF.SayCustom(CharGenSpouseCommentMouth)
		;hair banter
		ElseIf aiFlavor == 4
			FaceCommentRegion.SetValue(4.0)
			SpouseCommenterREF.SayCustom(CharGenSpouseCommentHair)
		;beard banter
		ElseIf aiFlavor == 5
			FaceCommentRegion.SetValue(5.0)
			SpouseCommenterREF.SayCustom(CharGenSpouseCommentBeard)
		EndIf
	EndIf

EndFunction

Event OnTimer(int aiTimerID)
	;must call function to disable SSR/Godrays every few seconds or failsafe will turn off
	;85743 - make sure the timer always turns off if the mirror sequence is done
	If (aiTimerID == 50) && (var_MirrorSequenceDone == 0)
		;debug.trace(self + "Must call ForceDisableSSRGodraysDirLight every second or so to keep the failsafe from turning it off")
		StartTimer(1.0, 50)
		Game.ForceDisableSSRGodraysDirLight(True, True, True)
	EndIf

	;mirror comment timer
	If (aiTimerID == CommentTimerID)
		If var_CommentsOff == 1
			var_CommentsOff = 2
		ElseIf var_CommentsOff == 2
			var_CommentsOff = 3
		Else
			var_CommentsOff = 0
		EndIf
	EndIf

	;TRAILER ONLY
	If (aiTimerID == 99)
		SetStage(505)
	EndIf
EndEvent

;for baby crib animations
Function BabyCry()
	BabyActivator.GetRef().PlayAnimation("To_Crying")
EndFunction

Function BabyNeutral()
	BabyActivator.GetRef().PlayAnimation("To_Idle")
EndFunction

Function BabyGiggle()
	BabyActivator.GetRef().PlayAnimation("To_Giggle")
EndFunction


;//
Event OnTimer(int aiTimerID)
	If aiTimerID == MirrorIdleTalkTimerID
		If RunMirrorTimer == 1
			StartTimer(MirrorIdleTimer, MirrorIdleTalkTimerID)
			If var_PlayerGender == 0
				ActiveSpouse.GetActorRef().SayCustom(CharGenSpouseMirrorWaitTopic)
			Else
				Game.GetPlayer().SayCustom(CharGenSpouseMirrorWaitTopic)
			EndIf
		EndIf
	EndIf
EndEvent
//;

;track to make sure everyone is on the elevator
int ElevatorCurrent
int ElevatorTotal = 7

Function CheckElevator()
	ElevatorCurrent += 1
	If ElevatorCurrent == ElevatorTotal
		SetStage(500)
	EndIf
EndFunction

;this is checking when everyone is close enough to the elevator (stage 470 registers)
Event OnDistanceLessThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance)
	If akObj1 == Game.getplayer()
		UnregisterForDistanceEvents(akobj1, akobj2)	
		;lock controls	
		SetStage(495)
		CheckElevator()
	Else
		UnregisterForDistanceEvents(akobj1, akobj2)
		CheckElevator()

	EndIf
EndEvent

ObjectReference Property MQ101VaultTecRepAtDoorMarker Auto
Int SalesmanSoundID
Sound Property AMBExtSanctuaryHillsBedChargenLPMmarker Auto
ObjectReference Property MQ101SalesmanAmbientEnableMarker Auto

;handle the ambient sounds for the Salesman scene
Function PlaySalesmanSounds()
	SalesmanSoundID = AMBExtSanctuaryHillsBedChargenLPMmarker.Play(MQ101VaultTecRepAtDoorMarker)
	MQ101SalesmanAmbientEnableMarker.Enable()
EndFunction

Function StopSalesmanSounds()
	Sound.StopInstance(SalesmanSoundID)
	MQ101SalesmanAmbientEnableMarker.Disable()
EndFunction


Event OnLostLOS(ObjectReference akViewer, ObjectReference akTarget)
	;for the crib mobile scene, advance the quest if the player looks away after the scene timer expires
	debug.trace(self + "LOS LOST IN CHARGEN")
	If (GetStageDone(247) == 0)
		SetStage(247)
	EndIF
EndEvent

ReferenceAlias Property MrRussell Auto
ReferenceAlias Property MrAble Auto
ReferenceAlias Property MrsAble Auto

Keyword Property AnimArchetypeScared Auto

Function SuitTakersSwitchNeutral()
	MrRussell.GetActorRef().ChangeAnimArchetype(None)
	MrAble.GetActorRef().ChangeAnimArchetype(None)
	MrsAble.GetActorRef().ChangeAnimArchetype(None)
EndFunction

Function SuitTakersSwitchScared()
	MrRussell.GetActorRef().ChangeAnimArchetype(AnimArchetypeScared)
	MrAble.GetActorRef().ChangeAnimArchetype(AnimArchetypeScared)
	MrsAble.GetActorRef().ChangeAnimArchetype(AnimArchetypeScared)
EndFunction
