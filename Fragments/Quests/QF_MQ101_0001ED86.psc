;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Quests:QF_MQ101_0001ED86 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0000_Item_00
Function Fragment_Stage_0000_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;VERTICAL SLICE PATH

;stop clock
TimeScale.SetValueInt(0)

;make sure the player can't move
debug.trace(self + "New Game Start, disable player controls")
; Store layer on MQ03 - this works because MQ03 is a run-once quest, so its properties
; won't be cleared when it starts up
MQ03.VSEnableLayer = InputEnableLayer.Create()
MQ03.VSEnableLayer.DisablePlayerControls(abCamSwitch=True)

; move the player so that New Game button puts him in the right place
debug.trace(self + "New Game Start, move player to marker")

Actor PlayerREF = Game.GetPlayer()

PlayerREF.Moveto(CharGenPlayerMarker1)

; Force a short wait so the fade out request isn't made while the loading menu is up
; (which would cause it to be bashed when the loading menu goes away and tells the
; fade menu to fade in)
debug.trace(self + "Wait 0.1 seconds")
Utility.Wait(0.1)
debug.trace(self + "Finish waiting. Fade the game in.")

; play the opening BINK
Game.PlayBink( "Intro.bk2", abInterruptible=true, abIsNewGameBink=true )
; setting "abIsNewGameBink=true" ensures that there is a white screen to fade out after the bink is done.

;put the player in the pod
pMQPlayerCryopodREF.Activate(Game.GetPlayer())
pMQPlayerCryopodREF.PlayAnimation("g_idleSitInstant")

; remove all the player's stuff
PlayerREF.RemoveAllItems()

; give the player the right starting gear
PlayerREF.AddItem(pArmor_Vault111_Underwear, absilent=true)
PlayerREF.EquipItem(pArmor_Vault111_Underwear, absilent=true)
PlayerREF.AddItem(pPipboyDusty, absilent=true)
PlayerREF.EquipItem(pPipboyDusty, absilent=true)
PlayerREF.AddItem(pArmor_WeddingRing, absilent=true)
PlayerREF.EquipItem(pArmor_WeddingRing, absilent=true)

; fade the game in
CameraAttachGroggyWake01FX.Play(Game.GetPlayer())
pCryoWakeImod.Apply()
Game.FadeOutGame(False, True, 3.0, 0.1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0000_Item_01
Function Fragment_Stage_0000_Item_01()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;stop clock
TimeScale.SetValueInt(0)

;don't show compass
Game.SetCharGenHUDMode(1)

;no saving or waiting
Game.SetInCharGen(True, True, False)

;make sure the player can't move
kmyquest.MQ101EnableLayer = InputEnableLayer.Create()
kmyquest.MQ101EnableLayer.DisablePlayerControls(abLooking=True, abCamSwitch=True, abSneaking = True)
kmyquest.MQ101EnableLayer.EnableSprinting(False)

;disable Z-Key
kmyquest.MQ101EnableLayer.EnableZKey(False)

;Store actors for optimization
Actor PlayerREF = Game.GetPlayer()
Actor SpouseMaleREF = Alias_SpouseMale.GetActorRef()
Actor SpouseFemaleREF = Alias_SpouseFemale.GetActorRef()

;set charGen skeletons
PlayerREF.SetHasCharGenSkeleton()
SpouseFemaleREF.SetHasCharGenSkeleton()

;precache the face gen data
Game.PrecacheCharGen()

; move the player so that New Game button puts him in the right place
PlayerREF.MoveTo(pMQ101PlayerStartMarker01)

; setup spouse
;SpouseMaleREF.Disable()
Alias_ActiveSpouse.ForceRefTo(SpouseFemaleREF)

; Force a short wait so the fade out request isn't made while the loading menu is up
; (which would cause it to be bashed when the loading menu goes away and tells the
; fade menu to fade in)
debug.trace(self + "Wait 0.1 seconds")
Utility.Wait(0.1)
debug.trace(self + "Finish waiting. Fade the game in.")

; play the opening BINK
Game.PlayBink( "Intro.bk2", abInterruptible=true, abIsNewGameBink=true )
; setting "abIsNewGameBink=true" ensures that there is a white screen to fade out after the bink is done.

; remove all the player's stuff
PlayerREF.RemoveAllItems()

; give the player the right starting gear
PlayerREF.AddItem(pClothesMacCready, absilent=True)
PlayerREF.EquipItem(pClothesMacCready, absilent=True)
PlayerREF.AddItem(pArmor_WeddingRing, absilent=true)
PlayerREF.EquipItem(pArmor_WeddingRing, absilent=true)

;put player in sink
Alias_FaceGenSink.GetRef().Activate(PlayerREF, abDefaultProcessingOnly=True)

;set weather - this must be done after the load
;PrewarPlayerHouseInteriorWeather.ForceActive(True)

;turn off ambient particles
Weather.EnableAmbientParticles(False)

;disable SSR, Godrays, and Directional Lighting as they're not needed for FaceGen
;we need to call this function every second or else the failsafe will turn it off
Game.ForceDisableSSRGodraysDirLight(True, True, True)
kmyquest.StartTimer(1.0, 50)

;FX
CharGenCameraImod.Apply()
CharGenSinkSoundFXEnableMarker.Disable()

; give the load a second to get the player in the furniture
Utility.Wait(1.0)

CharGenMirrorImod.Apply()

; fade the game in
Game.FadeOutGame(False, False, 1.0, 2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0000_Item_03
Function Fragment_Stage_0000_Item_03()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;stop clock
TimeScale.SetValueInt(0)

;make sure the player can't move
kmyquest.MQ101EnableLayer = InputEnableLayer.Create()

;enable only walking, looking, activating
kmyquest.MQ101EnableLayer.EnablePlayerControls(abFighting = false, abSneaking = false, abMenu = false, abVats = false)

;set weather
;PrewarPlayerHouseInteriorWeather.ForceActive()

;Store actors for optimization
Actor PlayerREF = Game.GetPlayer()
Actor SpouseMaleREF = Alias_SpouseMale.GetActorRef()
Actor SpouseFemaleREF = Alias_SpouseFemale.GetActorRef()

; disable spouse based on player's gender and set ActiveSpouse
If (Game.GetPlayer().GetBaseObject() as ActorBase).GetSex() == 1
  SpouseFemaleREF.Disable()
  Alias_ActiveSpouse.ForceRefTo(SpouseMaleREF)
  SpouseMaleREF.Moveto(pMQ101SpouseStartMarker)
Else
   SpouseMaleREF.Disable()
   Alias_ActiveSpouse.ForceRefTo(SpouseFemaleREF)
   SpouseFemaleREF.Moveto(pMQ101SpouseStartMarker)
EndIf

PlayerREF.Moveto(MQ101PlayerSkipToExteriorMarker)

; Force a short wait so the fade out request isn't made while the loading menu is up
; (which would cause it to be bashed when the loading menu goes away and tells the
; fade menu to fade in)
debug.trace(self + "Wait 0.1 seconds")
Utility.Wait(0.1)
debug.trace(self + "Finish waiting. Fade the game in.")

; remove all the player's stuff
PlayerREF.RemoveAllItems()

; give the player the right starting gear
;player is female
If (Game.GetPlayer().GetBaseObject() as ActorBase).GetSex() == 1
  PlayerREF.AddItem(ClothesPrewarWomensCasual, absilent=true)
  PlayerREF.EquipItem(ClothesPrewarWomensCasual, absilent=true)
;player is male
Else
  PlayerREF.AddItem(ClothesPrewarTshirtSlacks, absilent=true)
  PlayerREF.EquipItem(ClothesPrewarTshirtSlacks, absilent=true)
EndIf
PlayerREF.AddItem(pArmor_WeddingRing, absilent=true)
PlayerREF.EquipItem(pArmor_WeddingRing, absilent=true)

; fade the game in
Game.FadeOutGame(False, True, 0.1, 0.1)

SetStage(70)
SetStage(220)
SetStage(230)
pMQ101BabyRoomDoorCollisionREF.Disable()
Alias_VaultTecRep.GetActorRef().Enable()
SetStage(270)
SetStage(300)
SetStage(310)
SetStage(400)
MQ101ShaunRoomCollisionEnableMArker.Disable()
;wait for 3d to load
Utility.Wait(2.0)
;set the Vault Elevator to be in correct position
Alias_ExtVaultElevator.GetRef().PlayAnimation("Stage5")
SetStage(18)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0000_Item_04
Function Fragment_Stage_0000_Item_04()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;stop clock
TimeScale.SetValueInt(0)

;make sure the player can't move
kmyquest.MQ101EnableLayer = InputEnableLayer.Create()

;enable only walking, looking, activating
kmyquest.MQ101EnableLayer.EnablePlayerControls(abFighting = false, abSneaking = false, abMenu = false, abVats = false)

;enable neighbors
MQ101HillSoldiersEnableMarker.Disable()

;Store actors for optimization
Actor PlayerREF = Game.GetPlayer()
Actor SpouseMaleREF = Alias_SpouseMale.GetActorRef()
Actor SpouseFemaleREF = Alias_SpouseFemale.GetActorRef()

; disable spouse based on player's gender and set ActiveSpouse
If (Game.GetPlayer().GetBaseObject() as ActorBase).GetSex() == 1
  SpouseFemaleREF.Disable()
  Alias_ActiveSpouse.ForceRefTo(SpouseMaleREF)
Else
   SpouseMaleREF.Disable()
   Alias_ActiveSpouse.ForceRefTo(SpouseFemaleREF)
EndIf

;move player
Game.GetPlayer().MoveTo(MQ101PlayerElevatorMarker)

;give the quest a second to load
Utility.Wait(2.0)

; remove all the player's stuff
PlayerREF.RemoveAllItems()

; give the player the right starting gear
;player is female
If (Game.GetPlayer().GetBaseObject() as ActorBase).GetSex() == 1
  PlayerREF.AddItem(ClothesPrewarWomensCasual, absilent=true)
  PlayerREF.EquipItem(ClothesPrewarWomensCasual, absilent=true)
;player is male
Else
  PlayerREF.AddItem(ClothesPrewarTshirtSlacks, absilent=true)
  PlayerREF.EquipItem(ClothesPrewarTshirtSlacks, absilent=true)
EndIf
PlayerREF.AddItem(pArmor_WeddingRing, absilent=true)
PlayerREF.EquipItem(pArmor_WeddingRing, absilent=true)


SetStage(270)
SetStage(500)
SetStage(600)

pMQ101_001_MirrorScene.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;push sound category for interior
CSMQ101PlayerHouseInt.Push(4.0)

;don't allow the player to open the door yet
Alias_PlayerHouseDoor.GetRef().BlockActivation(True, True)

;turn on the radio
pRadioSanctuaryHillsPrewar.Start()
Alias_RadioTransmitter.GetRef().Enable()

;turn off sink soundFX
CharGenSinkSoundFXEnableMarker.Disable()

;player can only fast walk
Game.GetPlayer().ChangeAnimArchetype(AnimArchetypeFastWalk)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0012_Item_00
Function Fragment_Stage_0012_Item_00()
;BEGIN CODE
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0015_Item_00
Function Fragment_Stage_0015_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;start checking when the player switches gender so appropriate spouse plays idle lines
kmyquest.TrackMirrorGenderSwitch()

;player must start facegen in neutral
Game.GetPlayer().ChangeAnimFaceArchetype(AnimFaceArchetypeNeutral)

;start headtrack targets
;Game.GetPlayer().SetLookat(MQ101MirrorMarker)
;Alias_ActiveSpouse.GetActorRef().SetLookAT(MQ101MirrorMarker)

;also start tracking for menu exit
kmyquest.RegisterForAnimationEvent(Game.GetPlayer(), "ChargenSkeletonReset")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0018_Item_00
Function Fragment_Stage_0018_Item_00()
;BEGIN CODE
pMQ101_001_MirrorScene.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0022_Item_00
Function Fragment_Stage_0022_Item_00()
;BEGIN CODE
Alias_BabyActivator.GetRef().BlockActivation(True, True)
Alias_CribStatic.GetRef().BlockActivation(True, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0030_Item_00
Function Fragment_Stage_0030_Item_00()
;BEGIN CODE
;Do not do this anymore, causes a pop if the skeleton is finishing the re-init when she switches package
;pull the female spouse chargen skeleton when she is off-screen
;Alias_SpouseFemale.GetActorRef().SetHasCharGenSkeleton(False)

pMQ101_002_CodsworthScene01.Start()

;turn on TV
pMQ101TVStation.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0063_Item_00
Function Fragment_Stage_0063_Item_00()
;BEGIN CODE
pMQ101_002_CodsworthScene01.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0065_Item_00
Function Fragment_Stage_0065_Item_00()
;BEGIN CODE
Alias_CodsworthPrewar.GetActorRef().PlayIdle(HandyUnEquipCoffeePot)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0070_Item_00
Function Fragment_Stage_0070_Item_00()
;BEGIN CODE
;spouse moves
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()
pMQ101_004_ShaunCries.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0075_Item_00
Function Fragment_Stage_0075_Item_00()
;BEGIN CODE
;Alias_CodsworthPrewar.GetActorRef().PlayIdle(HandyUnEquipDuster)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0080_Item_00
Function Fragment_Stage_0080_Item_00()
;BEGIN CODE
Alias_CodsworthPrewar.GetActorRef().EvaluatePackage()

SetStage(90)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0085_Item_00
Function Fragment_Stage_0085_Item_00()
;BEGIN CODE
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()

SetStage(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0090_Item_00
Function Fragment_Stage_0090_Item_00()
;BEGIN CODE
;enable vault-tec rep
;Alias_VaultTecRep.GetActorRef().Enable()

pMQ101_005_Doorbell.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0092_Item_00
Function Fragment_Stage_0092_Item_00()
;BEGIN CODE
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0093_Item_00
Function Fragment_Stage_0093_Item_00()
;BEGIN CODE
Alias_VaultTecRep.GetActorRef().ChangeAnimFlavor(AnimFlavorClipboardSalesman)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0095_Item_00
Function Fragment_Stage_0095_Item_00()
;BEGIN CODE
;allow the player to open the door
;keep activation blocked so the VTec rep doesn't path into it and open it
;OnActivate block on the alias script sets stage 97 which opens the door instead
Alias_PlayerHouseDoor.GetRef().BlockActivation(True, False)

Alias_VaultTecRep.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0097_Item_00
Function Fragment_Stage_0097_Item_00()
;BEGIN CODE
;don't allow activation again
Alias_PlayerHouseDoor.GetRef().BlockActivation(True, True)

;make sure the door always open
Alias_PlayerHouseDoor.GetRef().SetOpen()

;stop scenes
pMQ101_005_Doorbell.Stop()
MQ101_005_DoorbellRepeat.Stop()

; spouse goes to the couch
Actor SpouseREF = Alias_ActiveSpouse.GetActorRef()
SpouseREF.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0100_Item_00
Function Fragment_Stage_0100_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
MQ101_006_VaultTecRep.Start()

kmyquest.PlaySalesmanSounds()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0110_Item_00
Function Fragment_Stage_0110_Item_00()
;BEGIN CODE
Alias_VaultTecRep.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0120_Item_00
Function Fragment_Stage_0120_Item_00()
;BEGIN CODE
;shut door and don't allow activation
Alias_PlayerHouseDoor.GetRef().SetOpen(False)
Alias_PlayerHouseDoor.GetRef().BlockActivation(True, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0200_Item_00
Function Fragment_Stage_0200_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;shut door and don't allow activation
Alias_PlayerHouseDoor.GetRef().SetOpen(False)
Alias_PlayerHouseDoor.GetRef().BlockActivation(True, True)

;block closing the baby room door
Alias_BabyRoomDoor.GetRef().SetOpen()
Alias_BabyRoomDoor.GetRef().BlockActivation(True, True)

;block crib mobile
Alias_CribMobile.GetRef().BlockActivation(True, True)

;player can now activate front door closet
Alias_PlayerFrontDoorCloset.GetRef().BlockActivation(False, False)

Alias_VaultTecRep.GetActorRef().EvaluatePackage()
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()

MQ101_006_VaultTecRep.Stop()
MQ101_007_PlayerDoesntSign.Stop()
pMQ101_008_AfterSign.Start()

kmyquest.StopSalesmanSounds()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0210_Item_00
Function Fragment_Stage_0210_Item_00()
;BEGIN CODE
pMQ101_009_GotoShaun.Start()
Alias_CodsworthPrewar.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0220_Item_00
Function Fragment_Stage_0220_Item_00()
;BEGIN CODE
;make sure player can activate crib
Alias_ShaunCrib.GetRef().BlockActivation(False, False)
Alias_BabyActivator.GetRef().BlockActivation(False, False)

Alias_CodsworthPrewar.getActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0230_Item_00
Function Fragment_Stage_0230_Item_00()
;BEGIN CODE
Actor SpouserEF = Alias_ActiveSpouse.GetActorRef()
Actor CodsworthREF = Alias_CodsworthPrewar.GetActorRef()
ObjectReference BabyRoomDoorREF = Alias_BabyRoomDoor.GetRef()

;don't let the player activate baby shaun anymore
Alias_BabyActivator.GetRef().BlockActivation(True, True)
Alias_CribStatic.GetRef().BlockActivation(True, True)
Alias_ShaunCrib.GetRef().BlockActivation(True, True)

;move Codsworth in case he's trapped in the reoom
CodsworthREF.Moveto(MQ101CodsworthStartMarker)

;turn off CharGen skeleton on spouse
;SpouseREF.SetHasCharGenSkeleton(False)
;Utility.Wait(0.1)

;move spouse into position using furniture quick enter
SpouseREF.EvaluatePackage()
SpouseREF.MoveTo(MQ101SpouseLeanREF)
SpouseREF.SnapIntoInteraction(MQ101SpouseLeanREF)

;block player from leaving
MQ101ShaunRoomCollisionEnableMArker.EnableNoWait()
BabyRoomDoorREF.BlockActivation(True, True)
BabyRoomDoorREF.SetOpen()

;Codsworth goes to TV
Alias_CodsworthPrewar.GetActorRef().EvaluatePackage()

;make sure we enable Vertibirds before Power Armor Soldiers so they snap into it
MQ101VertibirdsEnableMarker.Disable()

;enable soldiers outside, move actors to positions
MQ101StreetSoldiersEnableMarker.DisableNoWait()
MQ101StreetNeighborsEnableMarker.DisableNoWait()
pMQ101SoldiersEnableMarker.DisableNoWait()
MQ101RunnersEnableMarker.DisableNoWait()
MQ101VertibirdBEnableMarker.DisableNoWait()
Alias_VaultTecRep.GetActorRef().DisableNoWait()
MQ101VertibirdCEnableMarker.DisableNoWait()

;set the Vault Elevator to be in correct position
Alias_ExtVaultElevator.GetRef().PlayAnimation("Stage5")

;spouse talks to player
pMQ101_010_SpouseMobile.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0240_Item_00
Function Fragment_Stage_0240_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
Alias_CribMobile.GetRef().BlockActivation(False, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0245_Item_00
Function Fragment_Stage_0245_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;check if the player looks away from the spouse after the scene timer expires
;kmyquest.RegisterForDetectionLOSLost(Game.GetPlayer(), Alias_ActiveSpouse.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0247_Item_00
Function Fragment_Stage_0247_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;kmyquest.UnRegisterForLOS(Game.GetPlayer(), Alias_ActiveSpouse.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0250_Item_00
Function Fragment_Stage_0250_Item_00()
;BEGIN CODE
pMQ101_010_SpouseMobile.Stop()

;disable front collision and enable back collision
MQ101ShaunRoomCollisionEnableMarker.Disable()
MQ101ShaunRoomCollisionEnableMarker002.Enable()

Alias_CribMobile.GetRef().BlockActivation(True, True)

;move spouse into position
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()
;Alias_ActiveSpouse.GetActorRef().Moveto(pMQ101SpouseInsideBabyRoomMarker)

;spouse talks to player
pMQ101_011_MobileSpin.Start()

;no need to check for LOS anymore for this scene
;SetStage(247)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0252_Item_00
Function Fragment_Stage_0252_Item_00()
;BEGIN CODE
ObjectReference BabyRoomDoorREF = Alias_BabyRoomDoor.GetRef()

;block player from leaving
BabyRoomDoorREF.SetOpen(False)
BabyRoomDoorREF.BlockActivation(True, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0260_Item_00
Function Fragment_Stage_0260_Item_00()
;BEGIN CODE
;allow player to leave baby room
Alias_BabyRoomDoor.GetRef().BlockActivation(False, False)
MQ101ShaunRoomCollisionEnableMArker.Disable()
MQ101ShaunRoomCollisionEnableMarker002.Disable()
pMQ101FrontDoorCollisionREF.Disable()

;disable music
MQ101CribMusicREF.Disable()

;please stand by screen
pMQ101TVStation.SetStage(50)
pMQ101TVStation.SetStage(20)

;set spouse face to nervous
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()
Alias_ActiveSpouse.GetActorRef().ChangeAnimFaceArchetype(AnimFaceArchetypeNervous)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0263_Item_00
Function Fragment_Stage_0263_Item_00()
;BEGIN CODE
Alias_ActiveSpouse.GetActorRef().SetLookAt(Alias_CodsworthPrewar.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0270_Item_00
Function Fragment_Stage_0270_Item_00()
;BEGIN CODE
Actor SpouseREF = Alias_ActiveSpouse.GetActorRef()
ActorBase PlayerBASE = (Game.GetPlayer().GetBaseObject() as ActorBase)

;spouse is female, set outfit and anim archetype on her
If PlayerBASE .GetSex() == 0
  SpouseREF.SetOutfit(pMQ101SpouseFemaleBabyOutfit)
  Utility.Wait(0.1)
  SpouseREF.ChangeAnimFlavor(AnimFlavorHoldingBaby)
;spouse is male, set outfit and anim archetype on him
Else
  SpouseREF.SetOutfit(MQ101SpouseMaleBabyOutfit)
  Utility.Wait(0.1)
  SpouseREF.ChangeAnimFlavor(AnimFlavorHoldingBaby)
EndIf

;make sure baby is equipped
SpouseREF.EquipItem(BabyBundled)

;spouse follows player
SpouseREF.EvaluatePackage()

;spouse no longer headtracks Codsworth
SpouseREF.ClearLookAt()

;disable crib sounds
ShaunBabyAudioRepeaterActivator.Disable()
ShaunIdleSoundMarkerREF.Disable()

;disable baby
Alias_BabyActivator.GetRef().Disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0300_Item_00
Function Fragment_Stage_0300_Item_00()
;BEGIN CODE
pMQ101_011_MobileSpin.Stop()
pMQ101TVStation.SetStage(100)

;radios go dead
MQ101Radio.SetStage(100)

;turn off player house comments
pMQ101PlayerComments.SetStage(1000)

;neighbor runs past window
Alias_NeighborWindowRunner.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0305_Item_00
Function Fragment_Stage_0305_Item_00()
;BEGIN CODE
;start air raid siren
pMQ101AirRaidSirenMarkerREF.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0310_Item_00
Function Fragment_Stage_0310_Item_00()
;BEGIN CODE
pMQ101_010_AfterNukeTV.Start()

;music
MUSSpecialChargenRunForTheVault.Add()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0400_Item_00
Function Fragment_Stage_0400_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;show  limited compass
Game.SetCharGenHUDMode(2)

SetObjectiveDisplayed(100, 1)

;allow player to run
Game.GetPlayer().ChangeAnimArchetype(AnimArchetypePlayer)
kmyquest.MQ101EnableLayer.EnablePlayerControls(abMovement = True, abFighting = False, abCamSwitch = True, abLooking = True, abSneaking = False, abMenu = False, abActivate = True, abJournalTabs = False, abVATS = False, abFavorites = False)
kmyquest.MQ101EnableLayer.EnableSprinting()

;allow player to use the front door
;just open door for now and advance quest
Alias_PlayerHouseDoor.GetRef().SetOpen()
Alias_PlayerHouseDoor.GetRef().BlockActivation(false, false)
pMQ101FrontDoorCollisionREF.Disable()

Alias_ActiveSpouse.getActorRef().EvaluatePackage()

;turn on ambient particles
Weather.EnableAmbientParticles()

SetStage(405)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0402_Item_00
Function Fragment_Stage_0402_Item_00()
;BEGIN CODE
;autosave request
Game.RequestAutoSave()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0405_Item_00
Function Fragment_Stage_0405_Item_00()
;BEGIN CODE
;force weather
;CommonwealthClear.ForceActive(True)

;tell Vertibird to land
pMQ101SanctuaryHills.Setstage(100)

;Vertibirds get louder
CSMQ101PlayerHouseInt.Remove()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0410_Item_00
Function Fragment_Stage_0410_Item_00()
;BEGIN CODE
pMQ101_013_EmergencyBroadcast.Start()

;make everyone in Sanctuary run to the vault
pMQ101PrewarSanctuaryHills.SetStage(10)

;start crowd panic noises
pMQ101CrowdPanicSoundMarkerREF.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0440_Item_00
Function Fragment_Stage_0440_Item_00()
;BEGIN CODE
;trigger suitcase scene
pMQ101SanctuaryHills.SetStage(70)

;update QT if player is ahead
setstage(425)

Alias_Solider_ListChecker.GetActorRef().ChangeAnimFlavor(AnimFlavorClipboardSalesman)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0450_Item_00
Function Fragment_Stage_0450_Item_00()
;BEGIN CODE
pMQ101_016_VaultTecRepSoldierScene.Start()
;make sure prior stages are set
SetStage(440)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0455_Item_00
Function Fragment_Stage_0455_Item_00()
;BEGIN CODE
Alias_VaultTecRep.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0460_Item_00
Function Fragment_Stage_0460_Item_00()
;BEGIN CODE
If GetStageDone(465) == 0
  MQ101_016b_SoldierGateLoop.Start()
EndIf
SetStage(455)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0465_Item_00
Function Fragment_Stage_0465_Item_00()
;BEGIN CODE
Alias_ActiveSpouse.GetActorRef().moveto(MQ101SpouseEscortMarker01)

;stop scene
MQ101_016_VaultTecRepSoldierScene.Stop()
MQ101_016b_SoldierGateLoop.Stop()

;get escort guy ready
MQ101SanctuaryHills.SetStage(75)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0470_Item_00
Function Fragment_Stage_0470_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
SetStage(465)

;tell the other quest that this happened
MQ101SanctuaryHills.SetStage(71)

;allow player to walk in
MQ101VaultGateCollisionREF.Disable()

Alias_ActiveSpouse.GetActorRef().EvaluatePackage()

;disable flying vertibird
MQ101VertibirdCEnableMarker.Enable()

;pMQ101_017_ListCheckingScene.Start()

;get elevator ready to descend
pPrewarVaultElevatorREF.PlayAnimation("stage6")

;move guy guarding gate
Alias_Solider_ListChecker.GetActorRef().EvaluatePackage()

;start tracking when people are on the elevator
kmyquest.RegisterForDistanceLessThanEvent(Game.GetPlayer(), MQ101ElevatorCenterMark, 150)
kmyquest.RegisterForDistanceLessThanEvent(Alias_MrAble, MQ101ElevatorCenterMark, 250)
kmyquest.RegisterForDistanceLessThanEvent(Alias_MrsAble, MQ101ElevatorCenterMark, 250)
kmyquest.RegisterForDistanceLessThanEvent(Alias_MrRussell, MQ101ElevatorCenterMark, 250)
kmyquest.RegisterForDistanceLessThanEvent(Alias_MrWhitfield, MQ101ElevatorCenterMark, 250)
kmyquest.RegisterForDistanceLessThanEvent(Alias_MrsWhitfield, MQ101ElevatorCenterMark, 250)
kmyquest.RegisterForDistanceLessThanEvent(Alias_ActiveSpouse, MQ101ElevatorCenterMark, 250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0480_Item_00
Function Fragment_Stage_0480_Item_00()
;BEGIN CODE
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0490_Item_00
Function Fragment_Stage_0490_Item_00()
;BEGIN CODE
;switch hidden objective off
SetObjectiveDisplayed(100, False)

;failsafe spouse move
If (GetStageDone(475) == 0) && (Game.GetPlayer().HasDirectLOS(MQ101SpouseFailsafeLookAtMarker) == False)
  Alias_ActiveSpouse.GetActorRef().moveto(MQ101SpouseFailsafeMoveMarker)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0495_Item_00
Function Fragment_Stage_0495_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
kmyquest.MQ101EnableLayer.DisablePlayerControls(abCamSwitch=True, absneaking=True)
;Game.ForceFirstPerson()

If GetStageDone(496) == 1
  SetStage(500)
EndIf

MUSSpecialChargenNukeA.Add()
Utility.Wait(0.5)
MUSSpecialChargenRunForTheVault.Remove()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0496_Item_00
Function Fragment_Stage_0496_Item_00()
;BEGIN CODE
If GetStageDone(495) == 1
  SetStage(500)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0497_Item_00
Function Fragment_Stage_0497_Item_00()
;BEGIN CODE
Alias_VaultTecElevatorEscort.GetActorRef().EvaluatePackage()

MQ101SanctuaryHills.SetStage(550)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0500_Item_00
Function Fragment_Stage_0500_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;stop other running scenes
MQ101SanctuaryHills.SetStage(95)

;stop crowd panic sounds
pMQ101CrowdPanicSoundMarkerREF.Disable()

;soldiers give the all clear to descend
pMQ101_017_ListCheckingScene.Stop()
pMQ101_018_ElevatorDescendScene.Start()

pPrewarVaultElevatorREF.PlayAnimation("stage6")
kmyquest.RegisterForAnimationEvent(CgNukeShockWaveRef, "WaveAboutToHit")
kmyquest.RegisterForAnimationEvent(CgNukeShockWaveRef, "WavePeopleReact")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0505_Item_00
Function Fragment_Stage_0505_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
Alias_MrAble.GetActorRef().PlayIdle(FlinchCharGenA)
Alias_MrsAble.GetActorRef().PlayIdle(FlinchCharGenA)
Alias_MrWhitfield.GetActorRef().PlayIdle(FlinchCharGenB)
Alias_MrsWhitfield.GetActorRef().PlayIdle(FlinchCharGenB)
Alias_MrRussell.GetActorRef().PlayIdle(FlinchCharGenC)

kmyquest.UnRegisterForAnimationEvent(CgNukeShockWaveRef, "WaveAboutToHit")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0510_Item_00
Function Fragment_Stage_0510_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
Actor SpouseREF = Alias_ActiveSpouse.GetActorRef()
Actor PlayerREF = Game.GetPlayer()

;elevator descends, cue nuke
(CG_NukeFXControlMarker as CGNukeFXControlScript).NukeBlast()
MUSSpecialChargenNukeB.Add()

;cue screams
MQ101_018_NukeExplodes.Start()

SpouseREF.PlayIdle(FlinchChargenA)
PlayerREF.PlayIdle(FlinchChargenA)

;wait for the descent, then cue fadeout
kmyquest.RegisterforAnimationEvent(pPrewarVaultElevatorRef, "FadetoBlack")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0515_Item_00
Function Fragment_Stage_0515_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
kmyquest.UnRegisterForAnimationEvent(CgNukeShockWaveRef, "WavePeopleReact")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0530_Item_00
Function Fragment_Stage_0530_Item_00()
;BEGIN CODE
Game.FadeOutGame(true, true, 1.0, 1.0, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0600_Item_00
Function Fragment_Stage_0600_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;put player in fast walk
Game.GetPlayer().ChangeAnimArchetype(AnimArchetypeFastWalk)

;store for script optimization
Actor SpouseREF = Alias_ActiveSpouse.getActorRef()
Actor MrAbleREF = Alias_MrAble.GetActorRef()
Actor MrsAbleREF = Alias_MrsAble.GetActorRef()
Actor MrRussellREF = Alias_MrRussell.GetActorRef()
Actor MrWhitfieldREF = Alias_MrWhitfield.GetActorRef()
Actor MrsWhitfieldREF = Alias_MrsWhitfield.GetActorRef()
Actor GuardREF = Alias_VaultTecElevatorEscort.GetActorRef()

;move spouse and others
SpouseREF.moveto(pMQ101SpouseElevatorMarker02)
MrAbleREF.Moveto(pMQ101MrAbleElevatorMarker02)
MrsAbleREF.Moveto(pMQ101MrsAbleElevatorMarker02)
MrRussellREF.Moveto(MQ101MrRussellElevatorMarker02)
MrWhitfieldREF.Moveto(MQ101MrWhitefieldElevatorMarker02)
MrsWhitfieldREF.Moveto(MQ101MrsWhitefieldElevatorMarker02)
;GuardREF.Moveto(MQ101GuardElevatorMarker)

;wait for everyone to load
Utility.Wait(2.0)

;Block activation on the suit giver
Alias_VaultTecSuitGiver.GetActorRef().BlockActivation()

;spouse face and body go back to normal
SpouseREF.PlayIdle(IdleStop)
;SpouseREF.ChangeAnimFlavor(AnimFlavorHoldingBaby)
SpouseREF.ChangeAnimFaceArchetype(AnimFaceArchetypePlayer)
SpouseREF.ChangeAnimArchetype()

;set everyone back to default anim sets
;don't do this anymore, the nuke reactions are no longer anim flavor so this step isn't necessary
;MrAbleREF.ChangeAnimFlavor()
;MrsAbleREF.ChangeAnimFlavor()
;MrRussellREF.ChangeAnimFlavor()
;MrWhitfieldREF.ChangeAnimFlavor()
;MrsWhitfieldREF.ChangeAnimFlavor()
;Game.GetPlayer().ChangeAnimFlavor()

;disable air raid siren
pMQ101AirRaidSirenMarkerREF.Disable()

;enable preloader doors
MQ203Vault111MagicDoorToPreWar.Enable()
PrewarVault111MagicDoor.Enable()

;make sure the pod is blocked if it isn't already
Alias_PlayerPod.GetRef().BlockActivation(True, True)

;wait for everyone to finish animating
Utility.Wait(3.0)

;lower elevator
Alias_VaultIntElevator.GetRef().PlayAnimation("stage2")

;shutdown sanctuary hills dialogue
pMQ101SanctuaryHills.SetStage(1000)

;fade game back up
Game.FadeOutGame(False, true, 1.0, 3.0)

Utility.Wait(1.0)

kmyquest.MQ101EnableLayer.EnablePlayerControls(abMovement = True, abFighting = False, abCamSwitch = True, abLooking = True, abSneaking = False, abMenu = False, abActivate = True, abJournalTabs = False, abVATS = False, abFavorites = False)
kmyquest.MQ101EnableLayer.EnableSprinting(False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0620_Item_00
Function Fragment_Stage_0620_Item_00()
;BEGIN CODE
MQ101_019a_Vault111Greeting01a.Start()
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()

;make sure cryopods are in the open state
Alias_SpousePod.GetRef().PlayAnimation("Stage2")
;Alias_PlayerPod.GetRef().PlayAnimation("standStart")
Alias_MrCallahanPod.GetRef().PlayAnimation("Stage2")
Alias_MrsCallahanPod.GetRef().PlayAnimation("Stage2")
Alias_NeighborCryopod01.GetRef().PlayAnimation("Stage2")
Alias_NeighborCryopod02.GetRef().PlayAnimation("Stage2")
Alias_NeighborCryopod03.GetRef().PlayAnimation("Stage2")
Alias_NeighborCryopod04.GetRef().PlayAnimation("Stage2")

;load Kellogg sequence for later
pMQ101KelloggSequence.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0620_Item_01
Function Fragment_Stage_0620_Item_01()
;BEGIN CODE
pMQ101_001_MirrorScene.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0625_Item_00
Function Fragment_Stage_0625_Item_00()
;BEGIN CODE
MQ101_019a_Vault111Greeting01b.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0630_Item_00
Function Fragment_Stage_0630_Item_00()
;BEGIN CODE
SetObjectiveCompleted(100)
SetObjectiveDisplayed(130)

;put the Whitfields into furniture
Alias_MrWhitfield.GetActorRef().EvaluatePackage()
Alias_MrsWhitfield.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0632_Item_00
Function Fragment_Stage_0632_Item_00()
;BEGIN CODE
Alias_ActiveSpouse.GetActorRef().EvaluatePackage()

Alias_MrWhitfield.GetActorRef().EvaluatePackage()
Alias_MrsWhitfield.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0635_Item_00
Function Fragment_Stage_0635_Item_00()
;BEGIN CODE
MQ101_019a_Vault111PA.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0646_Item_00
Function Fragment_Stage_0646_Item_00()
;BEGIN CODE
;tell player to take a suit
MQ101_019a_Vault111Greeting03.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0647_Item_00
Function Fragment_Stage_0647_Item_00()
;BEGIN CODE
MQ101_019a_Vault111Greeting02.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0648_Item_00
Function Fragment_Stage_0648_Item_00()
;BEGIN CODE
MQ101_019a_Vault111Greeting02.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0649_Item_00
Function Fragment_Stage_0649_Item_00()
;BEGIN CODE
MQ101_019a_Vault111Greeting02.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0670_Item_00
Function Fragment_Stage_0670_Item_00()
;BEGIN CODE
;SetObjectiveCompleted(110, 1)
;SetObjectiveDisplayed(130, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0675_Item_00
Function Fragment_Stage_0675_Item_00()
;BEGIN CODE
;give player the suit message
Actor PlayerREF = Game.GetPlayer()
PlayerREF.AddItem(Armor_Vault111Clean_Underwear)
PlayerREF.RemoveItem(Armor_Vault111Clean_Underwear, absilent=True)

;move spouse failsafe
If Game.GetPlayer().HasDirectLOS(Alias_ActiveSpouse.GetActorRef()) == False
  Alias_ActiveSpouse.GetActorRef().moveto(MQ101Vault111SpouseEscortMarker01)
EndIf

MQ101_019a_Vault111Greeting02.Stop()
MQ101_019a_Vault111Greeting03.Stop()
MQ101_020_Vault111Suit.Start()

;turn activation back on for suit giver
Alias_VaultTecSuitGiver.GetActorRef().BlockActivation(False, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0680_Item_00
Function Fragment_Stage_0680_Item_00()
;BEGIN CODE
SetObjectiveCompleted(130, 1)
SetObjectiveDisplayed(140, 1)

;trigger extra Vault 111 scene
pMQ101Vault111.SetStage(10)

Alias_VaultTecEscort.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0685_Item_00
Function Fragment_Stage_0685_Item_00()
;BEGIN CODE
Alias_V111LockedDoor.GetRef().Lock(False)
Alias_V111LockedDoor.GetRef().SetOpen()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0690_Item_00
Function Fragment_Stage_0690_Item_00()
;BEGIN CODE
;begin escort scene
pMQ101_020_Vault11ToPods.Start()

Alias_VaultTecEscort.GetActorRef().EvaluatePackage()

;make sure the pod is blocked if it isn't already
Alias_PlayerPod.GetRef().BlockActivation(True, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0700_Item_00
Function Fragment_Stage_0700_Item_00()
;BEGIN CODE
Actor SpouseREF = Alias_ActiveSpouse.GetActorRef()

SetObjectiveCompleted(140, 1)
SetObjectiveDisplayed(145, 1)

;allow player to activate pod 
Alias_PlayerPod.GetRef().BlockActivation(True, False)

;switch out name and prompt for spouse
Alias_SpouseFemaleName.Clear()
Alias_SpouseNameMale.Clear()

SpouseREF.BlockActivation(True, False)
Alias_ShaunName.ForceRefTo(SpouseREF)
SpouseREF.SetActivateTextOverride(MQ101ShaunActivationText)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0705_Item_00
Function Fragment_Stage_0705_Item_00()
;BEGIN CODE
MQ101_020a_Vault111ToPods.Stop()
MQ101_020b_Vault111Shaun.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0710_Item_00
Function Fragment_Stage_0710_Item_00()
;BEGIN CODE
Actor SpouseREF = Alias_ActiveSpouse.GetActorRef()

SetObjectiveCompleted(145, 1)
If GetStageDone(720) == 0
  SetObjectiveDisplayed(150, 1)
EndIf

;change spouse's name back
Alias_ShaunName.Clear()
If SpouseREF.GetActorBase().GetSex() == 0
  Alias_SpouseNameMalePermanent.ForceRefTo(SpouseRef)
Else
    Alias_SpouseFemaleNamePermanent.ForceRefTo(SpouseRef)
EndIf

SpouseREF.SetActivateTextOverride(None)
SpouseREF.BlockActivation(False, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0720_Item_00
Function Fragment_Stage_0720_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
Actor PlayerREF = Game.GetPlayer()
Actor SpouseREF = Alias_ActiveSpouse.GetActorRef()

;disable saving
Game.SetInCharGen(True, True, False)

;disable player controls - this is now done on the script for the PlayerPod alias
;kmyquest.MQ101EnableLayer.DisablePlayerControls(abactivate=false, abCamSwitch=True, abLooking=True)

SetObjectiveCompleted(140, 1)
SetObjectiveCompleted(145, 1)
SetObjectiveCompleted(150, 1)

;always stop other scenes
MQ101_020a_Vault111ToPods.Stop()
MQ101_020b_Vault111Shaun.Stop()
MQ101_019a_Vault111Greeting01b.Stop()

;play sound
QSTChargenVaultSuitOn.Play(PlayerREF)

PlayerREF.AddItem(Armor_Vault111Clean_Underwear, absilent=true)
PlayerREF.EquipItem(Armor_Vault111Clean_Underwear, absilent=true)

Utility.Wait(0.1)

;activate the pod
Alias_PlayerPod.GetRef().Activate(Game.GetPlayer(), True)

Utility.Wait(1.0)
;pop spouse to pod
SpouseREF.Disable()
SpouseREF.SetHasCharGenSkeleton(False)
SpouseREF.SetOutfit(MQ101SpouseVaultSuitBabyOutfit_Clean)
(pMQ101KelloggSequence as MQ101KelloggSequenceScript).SpouseSitPod = 1
SpouseREF.EvaluatePackage()
;SpouseREF.SnapIntoInteraction(Alias_SpousePod.GetRef())
SpouseREF.Enable()
SpouseREF.EquipItem(BabyBundled)

;disable other vault participants
MQ101HillSoldiersEnableMarker.Enable()

;clear prior stages
SetStage(710)
Setstage(715)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0730_Item_00
Function Fragment_Stage_0730_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;enable looking
kmyquest.MQ101EnableLayer.EnablePlayerControls(abMovement=False, abFighting=False, abCamSwitch=False, abLooking=True, abSneaking=False, abMenu=False, abActivate=True, abJournalTabs=False, abVATS=False, abFavorites=False)

;close other pods as well
Alias_SpousePod.GetRef().PlayAnimation("Stage1")
Alias_NeighborCryopod01.GetRef().PlayAnimation("Stage1")
Alias_NeighborCryopod02.GetRef().PlayAnimation("Stage1")

MQ101_020c_Vault111PodsSet.Start()

;player is in pod, modify audio
CSMQ101Cryopod.Push()

;Vault-Tec Scientists walk
Alias_VaultTecScientistF03Cryo.GetActorRef().EvaluatePackage()
Alias_VaultTecScientistM05Cryo.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0750_Item_00
Function Fragment_Stage_0750_Item_00()
;BEGIN CODE
pMQ101_022_FreezingSequence.Start()

;silently add pipboy
Actor PlayerREF = Game.GetPlayer()

PlayerREF.AddItem(pPipboyDusty, absilent=true)
PlayerREF.EquipItem(pPipboyDusty, absilent=true)

;spouse waves in cryopod
Alias_ActiveSpouse.GetActorRef().PlayIdle(IdleCryopodWaveToSpouse)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0752_Item_00
Function Fragment_Stage_0752_Item_00()
;BEGIN CODE
Alias_PlayerPod.GetRef().PlayAnimation("Freeze")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0753_Item_00
Function Fragment_Stage_0753_Item_00()
;BEGIN CODE
Game.FadeOutGame(abFadingOut=True, abBlackFade=False, afSecsBeforeFade=0.0, afFadeDuration=10.0, abStayFaded=True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0755_Item_00
Function Fragment_Stage_0755_Item_00()
;BEGIN CODE
;CameraAttachGroggySleep01FX.Play(Game.GetPlayer())
;CryoSleepImod.Apply()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0760_Item_00
Function Fragment_Stage_0760_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
Actor PlayerREF = Game.GetPlayer()
;turn off fast walk limiter
PlayerREF.ChangeAnimArchetype(AnimArchetypePlayer)
kmyquest.MQ101EnableLayer.EnableSprinting()

;gas soundFX
QSTPlayerCryopodGas.Play(Game.GetPlayer())

;force preloader if needed
PrewarVault111MagicDoor.PreloadTargetArea()

;wait a few seconds, then start Kellogg scene
Utility.Wait(6.0)

;swap to postwar vault suits
PlayerREF.AddItem(pArmor_Vault111_Underwear, absilent=true)
PlayerREF.EquipItem(pArmor_Vault111_Underwear, absilent=true)
PlayerREF.RemoveItem(Armor_Vault111Clean_Underwear, absilent=true)
Alias_ActiveSpouse.GetActorRef().SetOutfit(MQ101SpouseVaultSuitBabyOutfit)

SetStage(770)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0770_Item_00
Function Fragment_Stage_0770_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;move the player to the Kellogg sequence room
Game.GetPlayer().moveto(MQ101Vault111PreloadPlayerMoveMarker)
PrewarVault111MagicDoor.Activate(Game.GetPlayer())
Alias_ActiveSpouse.GetActorRef().RemoveKeyword(IsInCryopodAwake)

Utility.Wait(0.1)

;put the player in the pod
pMQ203PlayerCryopodREF.Activate(Game.GetPlayer(), True)
pMQ203PlayerCryopodREF.PlayAnimation("g_idleSitInstant")
pMQ203PlayerCryopodREF.BlockActivation()

(pMQ101KelloggSequence as MQ101KelloggSequenceScript).StartKelloggSequence()

Utility.Wait(3.0)

;start fading game in
Game.FadeOutGame(abFadingOut=False, abBlackFade=False, afSecsBeforeFade=2.0, afFadeDuration=10.0, abStayFaded=False)

;wait for fade-in
Utility.Wait(1.0)

;CameraAttachGroggyWake01FX.Play(Game.GetPlayer())
;CameraAttachGroggySleep01FX.Stop(Game.GetPlayer())
;cross fade to remove gradually
CryoSuspensionImod.ApplyCrossFade(0.0)
ImageSpaceModifier.RemoveCrossFade(60.0)

SetStage(780)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0780_Item_00
Function Fragment_Stage_0780_Item_00()
;BEGIN CODE
Alias_MQ203PlayerCryoPod.GetRef().PlayAnimation("Thaw")

;we no longer need the prewar magic door
MQ203Vault111MagicDoorToPreWar.Disable()
PrewarVault111MagicDoor.Disable()

;start loading postwar
MQ101Vault111PostWarMagicDoor.Enable()
MQ203Vault111MagicDoorToPostWar.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0805_Item_00
Function Fragment_Stage_0805_Item_00()
;BEGIN CODE
Alias_PlayerPod.GetRef().PlayAnimation("Freeze")
;CameraAttachGroggySleep01FX.Play(Game.GetPlayer())
;CryoSleepImod.Apply()
Game.FadeOutGame(abFadingOut=True, abBlackFade=False, afSecsBeforeFade=3.0, afFadeDuration=10.0, abStayFaded=True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0810_Item_00
Function Fragment_Stage_0810_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
;force preloader if needed
MQ203Vault111MagicDoorToPostWar.PreloadTargetArea()

;wait a few seconds
Utility.Wait(10.0)

;jump the player
SetStage(900)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0900_Item_00
Function Fragment_Stage_0900_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
; Store new layer on MQ03(MQ102) - this works because MQ03 is a run-once quest, so its properties
; won't be cleared when it starts up
MQ03.VSEnableLayer = InputEnableLayer.Create()
MQ03.VSEnableLayer.DisablePlayerControls(abCamSwitch=True, abLooking=True)
kmyquest.MQ101EnableLayer = None ; delete the old layer and let the MQ102 layer handle things from now on

Actor PlayerREF = Game.GetPlayer()

PlayerREF.Moveto(MQ101KelloggSeqMovePlayerForPreload)
MQ203Vault111MagicDoorToPostWar.Activate(PlayerREF)

Utility.Wait(0.1)

;put the player in the pod
pMQPlayerCryopodREF.Activate(PlayerREF)
pMQPlayerCryopodREF.PlayAnimation("g_idleSitInstant")

; remove all the player's stuff
PlayerREF.RemoveAllItems()

; give the player the right starting gear
PlayerREF.AddItem(pArmor_Vault111_Underwear, absilent=true)
PlayerREF.EquipItem(pArmor_Vault111_Underwear, absilent=true)
PlayerREF.AddItem(pPipboyDusty, absilent=true)
PlayerREF.EquipItem(pPipboyDusty, absilent=true)
PlayerREF.AddItem(pArmor_WeddingRing, absilent=true)
PlayerREF.EquipItem(pArmor_WeddingRing, absilent=true)

; fade the game in
;CameraAttachGroggySleep01FX.Stop(Game.GetPlayer())
;CameraAttachGroggyWake01FX.Play(Game.GetPlayer())
;pCryoWakeImod.Apply()
Game.FadeOutGame(False, False, 3.0, 10.0)

Utility.Wait(2.0)

;advance quest if the trigger didn't work
MQ102.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1000_Item_00
Function Fragment_Stage_1000_Item_00()
;BEGIN AUTOCAST TYPE mq101questscript
Quest __temp = self as Quest
mq101questscript kmyQuest = __temp as mq101questscript
;END AUTOCAST
;BEGIN CODE
CompleteAllObjectives()
;no longer need magic door to post war
MQ203Vault111MagicDoorToPostWar.Disable()
MQ101Vault111PostWarMagicDoor.Disable()

;clear the input layer
kmyquest.MQ101EnableLayer = None

;allow saving
Game.SetInCharGen(False, False, False)

;shutdown the Vault111 prewar quest
MQ101Vault111.SetStage(1000)

kmyquest.MQ101EnableLayer.EnableSprinting()

Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_5000_Item_00
Function Fragment_Stage_5000_Item_00()
;BEGIN CODE
;LOAD EXPLOSION
(CG_NukeFXControlMarker as CGNukeFXControlScript).NukeBlast()
Utility.Wait(1.0)
;script kill player
Game.GetPlayer().Kill()
Alias_ActiveSpouse.GetActorRef().Kill()

;Fade to white
Game.FadeOutGame(True, False, 1.0, 1.0, True)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property CharGenPlayerMarker1  Auto Const  
MQ03QuestScript Property MQ03 Auto Const

Armor Property pArmor_Vault111_Underwear Auto Const

ObjectReference Property pMQPlayerCryopodREF Auto Const

Armor Property pPipboyDusty Auto Const

Armor Property pArmor_WeddingRing Auto Const

ImageSpaceModifier Property pCryoWakeImod Auto Const

ObjectReference Property pMQ101PlayerStartMarker01 Auto Const

ReferenceAlias Property Alias_SpouseMale Auto Const

ReferenceAlias Property Alias_SpouseFemale Auto Const

ReferenceAlias Property Alias_ActiveSpouse Auto Const

Scene Property pMQ101_001_MirrorScene Auto Const

ObjectReference Property pMQ101SpouseStartMarker Auto Const

Scene Property pMQ101_002_CodsworthScene01 Auto Const

ReferenceAlias Property Alias_CodsworthPrewar Auto Const

ReferenceAlias Property Alias_PlayerHouseDoor Auto Const

ReferenceAlias Property Alias_VaultTecRep Auto Const

Scene Property pMQ101_004_ShaunCries Auto Const

Scene Property pMQ101_005_Doorbell Auto Const

ReferenceAlias Property Alias_RadioTransmitter Auto Const

Quest Property pRadioSanctuaryHillsPrewar Auto Const

Quest Property pMQ101TVStation Auto Const

Scene Property pMQ101_008_AfterSign Auto Const

Scene Property pMQ101_010_AfterNukeTV Auto Const

Scene Property pMQ101_009_GotoShaun Auto Const

ObjectReference Property pMQ101SpouseToBabyRoomMarker Auto Const

ObjectReference Property pMQ101BabyRoomDoorCollisionREF Auto Const

ReferenceAlias Property Alias_CribMobile Auto Const

Scene Property pMQ101_010_SpouseMobile Auto Const

Scene Property pMQ101_011_MobileSpin Auto Const

ObjectReference Property pMQ101SpouseInsideBabyRoomMarker Auto Const

ReferenceAlias Property Alias_BabyRoomDoor Auto Const

ReferenceAlias Property Alias_ShaunCrib Auto Const

ObjectReference Property pMQ101SoldiersEnableMarker Auto Const

ObjectReference Property pMQ101FrontDoorCollisionREF Auto Const

ObjectReference Property pMQ101VaultTecRepToVaultMarker Auto Const

Scene Property pMQ101_013_EmergencyBroadcast Auto Const

Quest Property pMQ101PrewarSanctuaryHills Auto Const

Scene Property pMQ101_016_VaultTecRepSoldierScene Auto Const

ReferenceAlias Property Alias_ExtVaultElevator Auto Const

Scene Property pMQ101_017_ListCheckingScene Auto Const

ReferenceAlias Property Alias_ExtElevatorButton Auto Const

Scene Property pMQ101_018_ElevatorDescendScene Auto Const

ObjectReference Property pPrewarVaultElevatorCollisionEnableMarker Auto Const

ObjectReference Property pPrewarVaultIntAutoloadDoor Auto Const

ObjectReference Property pPrewarVaultElevatorREF Auto Const

ReferenceAlias Property Alias_NeighborWindowRunner Auto Const

ObjectReference Property pMQ101SpouseElevatorMarker02 Auto Const

Scene Property pMQ101_019_Vault111Greeting Auto Const

ReferenceAlias Property Alias_VaultTecGreeter Auto Const

ReferenceAlias Property Alias_V111LockedDoor Auto Const

ReferenceAlias Property Alias_SpousePod Auto Const

ReferenceAlias Property Alias_PlayerPod Auto Const

Scene Property pMQ101_020_Vault11ToPods Auto Const

ReferenceAlias Property Alias_Solider_ListChecker Auto Const

ReferenceAlias Property Alias_Kellogg Auto Const

ReferenceAlias Property Alias_InstScientistFemale Auto Const

ReferenceAlias Property Alias_InstScientistMale Auto Const

Scene Property pMQ101_022_FreezingSequence Auto Const

ReferenceAlias Property Alias_MrAble Auto Const

ReferenceAlias Property Alias_MrsAble Auto Const

ObjectReference Property pMQ101MrAbleElevatorMarker02 Auto Const

ObjectReference Property pMQ101MrsAbleElevatorMarker02 Auto Const

Quest Property pMQ101Vault111 Auto Const

Quest Property pMQ101KelloggSequence Auto Const

Quest Property pMQ101SanctuaryHills Auto Const

ReferenceAlias Property Alias_VaultTecEscort Auto Const

ObjectReference Property pMQ101AirRaidSirenMarkerREF Auto Const

sound Property pFXExplosionNukeChargenA Auto Const

sound Property pFXExplosionNukeChargenB Auto Const

ObjectReference Property pMQ101CrowdPanicSoundMarkerREF Auto Const

Armor Property pClothesSweaterVest Auto Const

Armor Property pClothesPreWarDress Auto Const

Quest Property pMQ101PlayerComments Auto Const

ObjectReference Property pMQ101PlayerKellogSequenceMarker Auto Const

ObjectReference Property pMQ203PlayerCryopodREF Auto Const

Outfit Property pMQ101SpouseFemaleBabyOutfit Auto Const

Outfit Property MQ101SpouseMaleBabyOutfit Auto Const

Keyword Property AnimFlavorHoldingBaby Auto Const

Weather Property PrewarPlayerHouseInteriorWeather Auto Const

Weather Property CommonwealthClear Auto Const

ObjectReference Property MQ101CribMusicREF Auto Const

ReferenceAlias Property Alias_CribStatic Auto Const

ObjectReference Property MQ101VertibirdsEnableMarker Auto Const

ReferenceAlias Property Alias_PlayerCribAnim Auto Const

Armor Property BabyBundled Auto Const

Keyword Property AnimFaceArchetypeNervous Auto Const

Keyword Property AnimFaceArchetypePlayer Auto Const

ObjectReference Property MQ101PlayerSkipToExteriorMarker Auto Const

ObjectReference Property MQ101VertibirdBEnableMarker Auto Const

ObjectReference Property MQ101RunnersEnableMarker Auto Const

ObjectReference Property MQ101StreetSoldiersEnableMarker Auto Const

ObjectReference Property MQ101StreetNeighborsEnableMarker Auto Const

Keyword Property AnimFlavorClipboard Auto Const

ObjectReference Property MQ101VaultGateCollisionREF Auto Const

ObjectReference Property MQ101VertibirdCEnableMarker Auto Const

ObjectReference Property CG_NukeFXControlMarker Auto Const

Scene Property MQ101_018_NukeExplodes Auto Const

SoundCategorySnapshot Property CSMQ101PlayerHouseInt Auto Const

ObjectReference Property ShaunBabyAudioRepeaterActivator Auto Const

ObjectReference Property ShaunIdleSoundMarkerREF Auto Const

ObjectReference Property MQ101PlayerElevatorMarker Auto Const

ReferenceAlias Property Alias_VaultIntElevator Auto Const

ObjectReference Property MQ101HillSoldiersEnableMarker Auto Const

ReferenceAlias Property Alias_MrWhitfield Auto Const

ReferenceAlias Property Alias_MrsWhitfield Auto Const

ReferenceAlias Property Alias_MrRussell Auto Const

ObjectReference Property MQ101MrRussellElevatorMarker02 Auto Const

ObjectReference Property MQ101MrWhitefieldElevatorMarker02 Auto Const

ObjectReference Property MQ101MrsWhitefieldElevatorMarker02 Auto Const

Scene Property MQ101_020_Vault111Suit Auto Const

Outfit Property MQ101SpouseVaultSuitBabyOutfit Auto Const

sound Property QSTChargenVaultSuitOn Auto Const

ObjectReference Property PrewarVault111MagicDoor Auto Const

ObjectReference Property MQ101Vault111PreloadPlayerMoveMarker Auto Const

ObjectReference Property MQ101KelloggSeqMovePlayerForPreload Auto Const

ObjectReference Property MQ203Vault111MagicDoorToPostWar Auto Const

Quest Property MQ102 Auto Const

Armor Property ClothesPrewarTshirtSlacks Auto Const

Armor Property ClothesPrewarWomensCasual Auto Const

ReferenceAlias Property Alias_MrCallahanPod Auto Const

ReferenceAlias Property Alias_MrsCallahanPod Auto Const

Keyword Property AnimFlavorBombReaction Auto Const

VisualEffect Property CameraAttachGroggySleep01FX Auto Const

ImageSpaceModifier Property CryoSleepImod Auto Const

VisualEffect Property CameraAttachGroggyWake01FX Auto Const

ImageSpaceModifier Property CryoWakeImod Auto Const

ImageSpaceModifier Property CryoSuspensionImod Auto Const

Keyword Property IsInCryopodAwake Auto Const

ReferenceAlias Property Alias_MQ203PlayerCryopod Auto Const

Armor Property ChargenPlayerClothes Auto Const

Scene Property MQ101_020c_Vault111PodsSet Auto Const

ReferenceAlias Property Alias_ShaunName Auto Const

Message Property MQ101ShaunActivationText Auto Const

Scene Property MQ101_020b_Vault111Shaun Auto Const

Keyword Property AnimFlavorBombReactionBaby Auto Const

Scene Property MQ101_020a_Vault111ToPods Auto Const

ReferenceAlias Property Alias_FaceGenSink Auto Const

Idle Property HandyEquipDuster Auto Const

Idle Property HandyUnequipDuster Auto Const

ObjectReference Property MQ203Vault111MagicDoorToPreWar Auto Const

ObjectReference Property MQ101Vault111PostWarMagicDoor Auto Const

Scene Property MQ101_019a_Vault111Greeting02 Auto Const

Scene Property MQ101_019a_Vault111Greeting01b Auto Const

Scene Property MQ101_019a_Vault111Greeting01a Auto Const

Scene Property MQ101_019a_Vault111PA Auto Const

Scene Property MQ101_019a_Vault111Greeting03 Auto Const

ReferenceAlias Property Alias_NeighborCryopod01 Auto Const

ReferenceAlias Property Alias_NeighborCryopod02 Auto Const

ReferenceAlias Property Alias_NeighborCryopod03 Auto Const

ReferenceAlias Property Alias_NeighborCryopod04 Auto Const

ObjectReference Property MQ101ShaunRoomCollisionEnableMArker Auto Const

ReferenceAlias Property Alias_BabyActivator Auto Const

GlobalVariable Property TimeScale Auto Const

Scene Property MQ101_005_DoorbellRepeat Auto Const

Keyword Property AnimFaceArchetypeFriendly Auto Const

Quest Property MQ101Radio Auto Const

ObjectReference Property MQ101SpouseEscortMarker01 Auto Const

ObjectReference Property MQ101SpouseFailsafeLookAtMarker Auto Const

ObjectReference Property MQ101SpouseFailsafeMoveMarker Auto Const

ReferenceAlias Property Alias_VaultTecSuitGiver Auto Const

ObjectReference Property MQ101Vault111SpouseEscortMarker01 Auto Const

ObjectReference Property MQ101ElevatorCenterMark Auto Const

Quest Property MQ101SanctuaryHills Auto Const

ObjectReference Property MQ101MirrorMarker Auto Const

ObjectReference Property MQ101CodsworthStartMarker Auto Const

ObjectReference Property MQ101SpouseGateFailsafeMarker Auto Const

ReferenceAlias Property Alias_VaultTecElevatorEscort Auto Const

MusicType Property MUSSpecialChargenNukeA Auto Const

MusicType Property MUSSpecialChargenNukeB Auto Const

ObjectReference Property MQ101GuardElevatorMarker Auto Const

SoundCategorySnapshot Property CSMQ101Cryopod Auto Const

sound Property QSTPlayerCryopodGas Auto Const

ImageSpaceModifier Property CharGenCameraImod Auto Const

MusicType Property MUSSpecialChargenRunForTheVault Auto Const

ObjectReference Property CgNukeShockWaveRef Auto Const

Idle Property IdleLookAtOwnOutfit Auto Const

Idle Property HandyUnequipCoffeePot Auto Const

Keyword Property AnimArchetypeShocked Auto Const

LocationAlias Property Alias_PrewarVault111Location Auto Const

Keyword Property AnimArchetypeScared Auto Const

Outfit Property Vault111SuitNoPipboy Auto Const

Scene Property MQ101_016_VaultTecRepSoldierScene Auto Const

Armor Property Armor_Vault111Clean_Underwear Auto Const

Outfit Property MQ101SpouseVaultSuitBabyOutfit_Clean Auto Const

LocationAlias Property Alias_MQ203Location Auto Const

ReferenceAlias Property Alias_ShaunActivateTriggerBeforeScene Auto Const

ReferenceAlias Property Alias_VaultTecScientistF03Cryo Auto Const

ReferenceAlias Property Alias_VaultTecScientistM05Cryo Auto Const

Keyword Property AnimArchetypeFastWalk Auto Const

Keyword Property AnimArchetypePlayer Auto Const

Scene Property MQ101_016b_SoldierGateLoop Auto Const

Scene Property MQ101_006_VaultTecRep Auto Const

Quest Property MQ101Vault111 Auto Const

Idle Property FlinchChargenA Auto Const

Idle Property FlinchChargenB Auto Const

Idle Property FlinchChargenC Auto Const

Idle Property IdleCryopodWaveToSpouse Auto Const

LocationAlias Property Alias_PrewarSanctuaryHillsLocation Auto Const

ImageSpaceModifier Property CharGenMirrorImod Auto Const

Sound Property AMBIntChargenPlayerHouseBathroomSpotMirrorWipe Auto Const

ObjectReference Property CharGenSinkSoundFXEnableMarker Auto Const

ObjectReference Property MQ101SpouseLeanREF Auto Const

Keyword Property AnimFlavorClipboardSalesman Auto Const

Armor Property Armor_Vault111_Underwear Auto Const

Keyword Property AnimFaceArchetypeConfident Auto Const Mandatory

Keyword Property AnimFaceArchetypeNeutral Auto Const Mandatory

ReferenceAlias Property Alias_PlayerFrontDoorCloset Auto Const Mandatory

ObjectReference Property MQ101ShaunRoomCollisionEnableMarker002 Auto Const Mandatory

ReferenceAlias Property Alias_SpouseFemaleName Auto Const Mandatory

ReferenceAlias Property Alias_SpouseNameMale Auto Const Mandatory

ReferenceAlias Property Alias_SpouseFemaleNamePermanent Auto Const Mandatory

ReferenceAlias Property Alias_SpouseNameMalePermanent Auto Const Mandatory

Idle Property IdleStop Auto Const Mandatory

Scene Property MQ101_007_PlayerDoesntSign Auto Const Mandatory

Armor Property pClothesMacCready Auto Const
