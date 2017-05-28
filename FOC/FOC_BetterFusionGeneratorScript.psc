Scriptname FOC:FOC_BetterFusionGeneratorScript extends ObjectReference

import utility

Sound Property tempSFX Auto Const

Sound Property GeneratorOff Auto Const

Sound Property GeneratorBeep Auto Const

Sound Property GeneratorLoopSFX Auto Const

ObjectReference Property linkedLight Auto Const

ObjectReference Property TroubleMarker Auto Const

ObjectReference Property GeneratorLoopMarkerA Auto

ObjectReference Property GeneratorLoopMarkerB Auto Hidden Const

Form Property FusionCoreBaseObject Auto Const

ObjectReference myFusionCore

bool bCoreTaken = FALSE
float fOffTimerTotal = 1.0
float fOffTimerSoFar = 0.00

Event OnLoad()
	debug.trace("Fusion Generator: onLoad")
    debug.trace("My fusion core is "+ myFusionCore)
    debug.trace("Look for a nearby core...")

    myFusionCore = game.findClosestReferenceOfType(FusionCoreBaseObject, self.getPositionX(), self.getPositionY(), self.getPositionZ()+61.0, 80.0)

    if game.getPlayer().getItemCount(myFusionCore) >= 1
        debug.trace("Player has fusion core, which we do not want to count...")
        myFusionCore = NONE
        playAnimation("AutoFadeOut")
    endif

	if myFusionCore != NONE
    	registerForRemoteEvent(myFusionCore, "OnActivate")
    	debug.trace("Fusion Generator: Registered for remove activate on: "+myFusionCore)
    else
    	; no linked core.  Don't show up as active.
        playAnimation("End")
        playAnimation("Reset")
        playAnimation("autoFade")
	endif

	if GeneratorLoopMarkerA != NONE
		; no looping SFX marker in environment.  Create one.
		GeneratorLoopMarkerA = self.placeatme(GeneratorLoopSFX)
	endif

EndEvent

Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	debug.trace("Fusion Generator: Received remote Activate")
    if akSender == myFusionCore && bCoreTaken == FALSE
        bCoreTaken = TRUE
    	debug.trace("Fusion Generator: Core has been activated")
    	playAnimation("autoFade")
    	tempSFX.play(self)
        GeneratorOff.play(self)
        GeneratorLoopMarkerA.disable()
        if GeneratorLoopMarkerB
        	; only disable secondary marker if on exists.
        	GeneratorLoopMarkerB.disable()
        endif
    	WaitRandomSlice(11)
    	linkedLight.disable()
        GeneratorBeep.play(self)
    	WaitRandomSlice(10)
    	linkedlight.enable()
    	WaitRandomSlice(9)
    	linkedLight.disable()
        GeneratorBeep.play(self)
    	WaitRandomSlice(8)
    	linkedlight.enable()
    	WaitRandomSlice(7)
    	linkedLight.disable()
        GeneratorBeep.play(self)
    	WaitRandomSlice(6)
    	linkedlight.enable()
    	WaitRandomSlice(5)
    	linkedLight.disable()
        GeneratorBeep.play(self)
    	WaitRandomSlice(4)
    	linkedlight.enable()
    	WaitRandomSlice(3)
    	linkedLight.disable()
        GeneratorBeep.play(self)
    	WaitRandomSlice(2)
    	linkedlight.enable()
    	; last blink, use up any remaining time - or just do a 0.1 slice if we're close.
    	if fOffTimerSoFar < fOffTimerTotal
    		wait(fOffTimerTotal-fOffTimerSoFar)
    		fOffTimerSoFar += (fOffTimerTotal-fOffTimerSoFar)
    	else
    		wait(0.1)
    		fOffTimerSoFar += 0.1
    	endif
    	linkedlight.disable()
        GeneratorBeep.play(self)
        TroubleMarker.disable()
        debug.trace("Fusion Gen - Off after "+fOffTimerSoFar+" of "+fOffTimerTotal)
        gotostate("OFF")
    endif 
EndEvent

Function WaitRandomSlice(int Slices)
	; insert a wait of a random slice of time, but make sure th whole sequence takes a specific amount of time.
	; fOffTimerTotal == the MAX amount of time we'd like to spend, although we may go a bit over in total.  We're okay being dumb about that given the scope of this operation.
	; fOffTimerSoFar = 0.00 == the ACCRUED amount of time we've spent so far.  
	float fMin = 0.1
	float fMax = 1.5*(fOffTimerTotal/Slices)
	debug.trace("Fusion Gen - fOffTimerSoFar: "+fOffTimerSoFar+" || fOffTimerTotal: "+fOffTimerTotal)

	if (fOffTimerTotal - fOffTimerSoFar) < fMin
		; if we generated a tiny slice of time then force the min/max to be very small
		fMax = math.abs(fOffTimerTotal - fOffTimerSoFar)
		if fMax < 0.05
			fMax = 0.05 ; clamp to prevent hyper-short flickers
		endif
		fMin = fMax/2
	endif
	float myTime = randomFloat(fMin,fMax)
	fOffTimerSoFar += myTime
	debug.trace("Fusion Gen - flicker for "+myTime+" sec.")
	debug.trace("Fusion Gen - fMin: "+fMin+" || fMax: "+fMax)
	wait(myTime)
endFunction