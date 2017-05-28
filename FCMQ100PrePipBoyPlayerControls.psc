Scriptname FCMQ100PrePipBoyPlayerControls extends activemagiceffect

InputEnableLayer FCMQPrePipBoy
Event OnEffectStart(Actor akTarget, Actor akCaster)
FCMQPrePipBoy = InputEnableLayer.Create()
FCMQPrePipBoy.DisablePlayerControls(false, true, false, false, true, false, true, true, true, true)
EndEvent