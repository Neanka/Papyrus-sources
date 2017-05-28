Scriptname MQ101PlayerScript extends ReferenceAlias

ReferenceAlias Property	FaceGenSink Auto Const

ReferenceAlias Property SpouseMale Auto Const
ReferenceAlias Property SpouseFemale Auto Const
ReferenceAlias Property ActiveSpouse Auto Const
ReferenceAlias Property SpouseNameMale Auto Const
ReferenceAlias Property SpouseNameFemale Auto Const

ObjectReference Property CharGenLightsEnableMarker Auto Const
ObjectReference Property CharGenMirrorFXEnableMarker Auto Const
ObjectReference Property CharGenMirrorEnableMarker Auto Const
ImageSpaceModifier Property CharGenCameraImod Auto Const

Keyword Property AnimFaceArchetypeFriendly Auto Const
Keyword Property AnimFaceArchetypePlayer Auto Const

Idle Property HandyEquipCoffeePot Auto Const

Quest Property Tutorial Auto Const

ObjectReference Property CharGenSingleSinkMarkerREF Auto Const

Auto State WaitingState
	Event OnGetUp(ObjectReference akFurniture)
		If akFurniture == FaceGenSink.GetRef()
			gotoState("doneState")
			MQ101QuestScript MyQuest = (GetOwningQuest() as MQ101QuestScript)
			Actor PlayerREF = Game.GetPlayer()
			Actor SpouseMaleREF = SpouseMale.GetActorRef()
			Actor SpouseFemaleREF = SpouseFemale.GetActorRef()

			;remove skeletons
			;don't do this if we removed them already due to the player being female
			;WJS - only do this for the player, we need to disable the female skeleton later so we can snap her into furniture
			If PlayerREF.GetActorBase().GetSex() == 0
			  PlayerREF.SetHasCharGenSkeleton(False)
			  ;SpouseFemaleREF.SetHasCharGenSkeleton(False)
			EndIf

			;switch no collision variants of the sink/mirror
			CharGenMirrorEnableMarker.Disable()

			; set ActiveSpouse and name
			If (PlayerREF.GetBaseObject() as ActorBase).GetSex() == 1
			  ActiveSpouse.ForceRefTo(SpouseMaleREF)
			  SpouseNameMale.ForceRefTo(SpouseMaleREF)
			Else
			  SpouseMaleREF.DisableNoWait()
			  ActiveSpouse.ForceRefTo(SpouseFemaleREF)
			  SpouseNameFemale.ForceRefTo(SpouseFemaleREF)
			EndIf

			Actor ActiveSpouseREF = ActiveSpouse.GetActorRef()

			;spouse uses sink
			MyQuest.var_MirrorSequenceDone = 1
			ActiveSpouseREF.EvaluatePackage()
			ActiveSpouseRef.SnapIntoInteraction(CharGenSingleSinkMarkerREF)

			;clear IMOD
			CharGenCameraImod.Remove()

			;disable lights
			CharGenLightsEnableMarker.Disable()

			;make sure everyone has correct faces
			PlayerREF.ChangeAnimFaceArchetype(AnimFaceArchetypePlayer)
			ActiveSpouseREF.ChangeAnimFaceArchetype(AnimFaceArchetypeFriendly)

			;disable the mirror FX
			CharGenMirrorFXEnableMarker.Disable()

			;turn SSR, Godrays, and Directional Lighting back on
			debug.trace(self + " Cancel the SSR/Godray/DirLight timer")
			MyQuest.CancelTimer(50)
			debug.trace(self + " Turn SSR/Godray/DirLight back on")
			Game.ForceDisableSSRGodraysDirLight(False, False, False)

			; Fade into black
			Game.FadeOutGame(abFadingOut=True, abBlackFade=true, afSecsBeforeFade=0.0, afFadeDuration=3.0, abStayFaded=True)

			Utility.Wait(3.00)

			; enables FCMQ90's stage 10. 
			FCMQ90.SetStage(10)

			;delay switching to third person when female until the reset is finished inside MQ101QuestScript
			If PlayerREF.GetActorBase().GetSex() == 0
				MyQuest.MQ101EnableLayer.EnablePlayerControls(abMovement = True, abFighting = True, abCamSwitch = True, abLooking = True, abSneaking = True, abMenu = True, abActivate = True, abJournalTabs = True, abVATS = True, abFavorites = True)
			Else				
				MyQuest.MQ101EnableLayer.EnablePlayerControls(abMovement = True, abFighting = True, abCamSwitch = True, abLooking = True, abSneaking = True, abMenu = True, abActivate = True, abJournalTabs = True, abVATS = True, abFavorites = True)
			EndIf

			;stop playing spouse idle lines
			MyQuest.StopTrackingMirrorGenderSwitch()

			;Close out Facegen tutorial messages
			Tutorial.SetStage(2025)

			;no need for the precache data anymore
			Game.PrecacheCharGenClear()

			;allows saving again
			Game.SetInCharGen(False, False, False)

			; CharGen over!  Back to standard HUD mode
			Game.SetCharGenHUDMode(0)

			;Terminate MQ101
			MQ101.SetStage(1000)

		EndIf
	endEvent
EndState

State doneState
	Event OnGetUp(ObjectReference akFurniture)
		;do nothing
	endEvent
EndState

Quest Property MQ101 Auto Const

Quest Property FCMQ100 Auto Const

Quest Property pFCMQ90 Auto Const

Quest Property FCMQ90 Auto Const
